//
//  StoreItem.swift
//  ique
//
//  Created by PCDotFan on 2022/10/31.
//

import Foundation


struct StoreResources: Codable {
    var description: String
    var imageUrl: String
    var ratings: Int
}



struct SeatType: Codable {
    var id: Int?
    var name: String
}

struct StoreItem: Codable {
    var id: Int
    var merchantId: Int
    var name: String
    var type: String
    var address: String
    var status: String // onService, stopService
    var registerTime: Int
    var resources: StoreResources
    var phoneNumbers: [String]
    var seatTypes: [SeatType]
}
