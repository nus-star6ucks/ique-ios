//
//  API.swift
//  ique
//
//  Created by PCDotFan on 2022/10/31.
//

import Foundation
import KeychainSwift
import Alamofire

var token: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJpcXVldWUiLCJpc3MiOiJ1bXMiLCJ1c2VyVHlwZSI6Im1lcmNoYW50IiwiZXhwIjoxNjY3Mzk4MDQ4LCJpYXQiOjE2NjczOTI2NDgsInVzZXJJZCI6NCwianRpIjoiNDQxYzY1ZWYtMmRkMS00M2ZkLWJjYjQtMzZjYzViMTQxMWMyIiwidXNlcm5hbWUiOiJ3c3kifQ.gQr2KzCo1de2R-Q-7athDSC1dFj7CA82ihbAS71EcYo"

func getStores() async throws -> [StoreItem] {
    return try await AF
        .request("https://ique.vercel.app/api/stores/list",
                 method: .get,
                 headers: [
            "Content-Type": "application/json",
        ])
        .validate(statusCode: 200..<300)
        .serializingDecodable([StoreItem].self).value
}


func getTickets() async throws -> [TicketItem] {
//    let keychain = KeychainSwift()
//    let token = keychain.get("token")!
    
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
//    let keychain = KeychainSwift()
//    let token = keychain.get("token")!
    
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
//    let keychain = KeychainSwift()
//    let token = keychain.get("token")!
    
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
//    let keychain = KeychainSwift()
//    let token = keychain.get("token")!

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
//    let keychain = KeychainSwift()
//    let token = keychain.get("token")!

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


func login(username: String, password: String) async throws -> LoginResponse {
    return try await AF
        .request("https://ique.vercel.app/api/users/login", method: .post, parameters: [
            "username": username,
            "password": password
        ], encoder: JSONParameterEncoder.default)
        .validate(statusCode: 200..<300)
        .serializingDecodable(LoginResponse.self).value
}
