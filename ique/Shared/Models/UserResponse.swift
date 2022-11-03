//
//  UserResponse.swift
//  ique
//
//  Created by PCDotFan on 2022/11/1.
//

import Foundation

struct UserResponse: Codable {
    var id: Int
    var username: String
    var userType: String
    var phoneNumber: String
    var status: String?
    var createTime: Date
}
