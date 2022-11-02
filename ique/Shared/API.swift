//
//  API.swift
//  ique
//
//  Created by PCDotFan on 2022/10/31.
//

import Foundation
import KeychainSwift
import Alamofire
import SwiftUIRouter

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
          let keychain = KeychainSwift()
          keychain.delete("user")
          keychain.delete("token")
        }
        return completion(.doNotRetry)
    }
}

let interceptor = AuthRequestInterceptor()


func getStores() async throws -> [StoreItem] {
    return try await AF
        .request("https://ique.vercel.app/api/stores/list",
                 method: .get,
                 headers: [
                    "Content-Type": "application/json",
                 ],
                 interceptor: interceptor)
        .validate(statusCode: 200..<300)
        .serializingDecodable([StoreItem].self).value
}


func getTickets() async throws -> [TicketItem] {
    let keychain = KeychainSwift()
    let token = keychain.get("token")!
    
    return try await AF
        .request("https://ique.vercel.app/api/queues/tickets?userId=325",
                 method: .get,
                 headers: [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + token
        ])
        .validate(statusCode: 200..<300)
        .serializingDecodable([TicketItem].self).value
}


func getUser() async throws -> UserResponse {
    let keychain = KeychainSwift()
    let token = keychain.get("token")!
    
    return try await AF
        .request("https://ique.vercel.app/api/users",
                 method: .get,
                 headers: [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + token
        ])
        .validate(statusCode: 200..<300)
        .serializingDecodable(UserResponse.self).value
}

func refreshToken() async throws -> RefreshTokenResponse {
    let keychain = KeychainSwift()
    let token = keychain.get("token")!
    
    return try await AF
        .request("https://ique.vercel.app/api/users/refresh",
                 method: .get,
                 headers: [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + token
        ])
        .validate(statusCode: 200..<300)
        .serializingDecodable(RefreshTokenResponse.self).value
}


func getStoreDetail(storeId: String) async throws -> StoreDetail {
    let keychain = KeychainSwift()
    let token = keychain.get("token")!

    return try await AF
        .request("https://ique.vercel.app/api/stores/" + String(storeId),
                 method: .get,
                 headers: [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + token
        ])
        .validate(statusCode: 200..<300)
        .serializingDecodable(StoreDetail.self).value
}


func getTicketDetail(ticketId: String) async throws -> TicketDetail {
    let keychain = KeychainSwift()
    let token = keychain.get("token")!

    return try await AF
        .request("https://ique.vercel.app/api/queues/tickets/" + String(ticketId),
                 method: .get,
                 headers: [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + token
        ])
        .validate(statusCode: 200..<300)
        .serializingDecodable(TicketDetail.self).value
}

func queue(queueId: Int, storeId: Int) async throws -> QueueReponse {
    let keychain = KeychainSwift()
    let token = keychain.get("token")!
    
    let userJsonString = keychain.getData("user")
    let userData = try JSONDecoder().decode(UserResponse.self, from: userJsonString!)

    let customerId = userData.id
    
    return try await AF
        .request("https://ique.vercel.app/api/queues/tickets", method: .post,
                 parameters: [
            "queueId": queueId,
            "customerId": customerId,
            "storeId": storeId
        ],
                 headers: [
                     "Content-Type": "application/json",
                     "Authorization": "Bearer " + token
                 ])
        .validate(statusCode: 200..<300)
        .serializingDecodable(QueueReponse.self).value
}



func login(username: String, password: String) async throws -> LoginResponse {
    return try await AF
        .request("https://ique.vercel.app/api/users/login", method: .post, parameters: [
            "username": username,
            "password": password
        ], encoder: JSONParameterEncoder.default)
        .validate(statusCode: 200..<300)
        .serializingDecodable(LoginResponse.self).value
}
