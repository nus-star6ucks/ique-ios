//
//  API.swift
//  ique
//
//  Created by PCDotFan on 2022/10/31.
//

import Foundation
import KeychainSwift
import Alamofire

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
