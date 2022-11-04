//
//  API.swift
//  ique
//
//  Created by PCDotFan on 2022/10/31.
//

import Foundation
import Alamofire
import SwiftUIRouter
import SimpleKeychain
import Argon2Swift

enum APIRequestError: Error {
    case UserNotLoggedIn
    case UserDataNotFound
    case UserFailedFetch
}


class AuthRequestInterceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Alamofire.Session, completion: @escaping (Swift.Result<URLRequest, Swift.Error>) -> Void) {}

    func retry(
        _ request: Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        let response = request.task?.response as? HTTPURLResponse
        if (response?.statusCode == 401) {
            do {
                try keychain.deleteItem(forKey: "user")
                try keychain.deleteItem(forKey: "token")
            } catch {
                
            }
        }
        return completion(.doNotRetry)
    }
}

let interceptor = AuthRequestInterceptor()

let keychain = SimpleKeychain(service: "com.star6ucks.ique")

let umsApiBaseUrl = "https://mock.apifox.cn/m1/1701091-0-9ec0a847"

let qmsApiBaseUrl = "https://mock.apifox.cn/m1/1701091-0-default"

let smsApiBaseUrl = "https://mock.apifox.cn/m1/1701091-0-b519d081"
                              
func getUserFromKeyChain() throws -> UserResponse {
    guard try keychain.hasItem(forKey: "token") else {
        throw APIRequestError.UserNotLoggedIn
    }

    guard try keychain.hasItem(forKey: "user") else {
        throw APIRequestError.UserDataNotFound
    }

    do {
        let userJsonString = try keychain.string(forKey: "user")
        let userData = try JSONDecoder().decode(UserResponse.self, from: userJsonString.data(using: .utf8)!)
        
        return userData
    } catch {
        try keychain.deleteItem(forKey: "token")
        try keychain.deleteItem(forKey: "user")
        throw APIRequestError.UserFailedFetch
    }
}


func getStores() async throws -> [StoreItem] {
    return try await AF
        .request("\(smsApiBaseUrl)/stores/list",
                 method: .get,
                 headers: [
                    "Content-Type": "application/json",
                 ])
        .validate(statusCode: 200..<300)
        .serializingDecodable([StoreItem].self).value
}


func getTickets() async throws -> [TicketItem] {
    
    guard try keychain.hasItem(forKey: "token") else {
        throw APIRequestError.UserNotLoggedIn
    }
    
    let user = try getUserFromKeyChain()
    let token = try keychain.string(forKey: "token")
    
    return try await AF
        .request("\(qmsApiBaseUrl)/queues/tickets?userId=\(user.id)",
                 method: .get,
                 headers: [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + token
        ])
        .validate(statusCode: 200..<300)
        .serializingDecodable([TicketItem].self).value
}


func getUser() async throws -> UserResponse {
    
    guard try keychain.hasItem(forKey: "token") else {
        throw APIRequestError.UserNotLoggedIn
    }
    
    let token = try keychain.string(forKey: "token")

    
    return try await AF
        .request("\(umsApiBaseUrl)/users",
                 method: .get,
                 headers: [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + token
        ])
        .validate(statusCode: 200..<300)
        .serializingDecodable(UserResponse.self).value
}

func refreshToken() async throws -> RefreshTokenResponse {
    
    guard try keychain.hasItem(forKey: "token") else {
        throw APIRequestError.UserNotLoggedIn
    }
    
    let token = try keychain.string(forKey: "token")

    return try await AF
        .request("\(umsApiBaseUrl)/users/refresh",
                 method: .get,
                 headers: [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + token
        ])
        .validate(statusCode: 200..<300)
        .serializingDecodable(RefreshTokenResponse.self).value
}


func getStoreDetail(storeId: String) async throws -> StoreDetail {

    guard try keychain.hasItem(forKey: "token") else {
        throw APIRequestError.UserNotLoggedIn
    }
    
    let token = try keychain.string(forKey: "token")


    return try await AF
        .request("\(smsApiBaseUrl)/stores/" + String(storeId),
                 method: .get,
                 headers: [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + token
        ])
        .validate(statusCode: 200..<300)
        .serializingDecodable(StoreDetail.self).value
}


func getTicketDetail(ticketId: String) async throws -> TicketDetail {

    guard try keychain.hasItem(forKey: "token") else {
        throw APIRequestError.UserNotLoggedIn
    }
    
    let token = try keychain.string(forKey: "token")


    return try await AF
        .request("\(qmsApiBaseUrl)/queues/tickets/" + String(ticketId),
                 method: .get,
                 headers: [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + token
        ])
        .validate(statusCode: 200..<300)
        .serializingDecodable(TicketDetail.self).value
}

func queue(queueId: Int, storeId: Int) async throws -> QueueReponse {
    do {
        let user = try getUserFromKeyChain()        
        let token = try keychain.string(forKey: "token")
        
        return try await AF
            .request("\(qmsApiBaseUrl)/queues/tickets?queueId=\(queueId)&customerId=\(user.id)&storeId=\(storeId)", method: .post,
             headers: [
                 "Content-Type": "application/json",
                 "Authorization": "Bearer " + token
             ])
            .validate(statusCode: 200..<300)
            .serializingDecodable(QueueReponse.self).value
    } catch {
        throw APIRequestError.UserFailedFetch
    }
}


func login(username: String, password: String) async throws -> LoginResponse {
    return try await AF
        .request("\(umsApiBaseUrl)/users/login", method: .post, parameters: [
            "username": username,
            "password": try hashPassword(password: password)
        ], encoder: JSONParameterEncoder.default)
        .validate(statusCode: 200..<300)
        .serializingDecodable(LoginResponse.self).value
}

func hashPassword(password: String) throws -> String {
    let salt = Salt(bytes: String(ProcessInfo.processInfo.environment["HASH_SALT"] ?? "").data(using: .utf8)!)
    let result = try! Argon2Swift.hashPasswordString(password: password, salt: salt)
    
    return result.encodedString()
}
