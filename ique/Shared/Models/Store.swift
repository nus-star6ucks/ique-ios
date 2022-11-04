//
//  StoreItem.swift
//  ique
//
//  Created by PCDotFan on 2022/10/31.
//

import Foundation
import DefaultCodable

struct StoreResources: Codable {
    var description: String
    var imageUrl: String
    var ratings: Float
}


struct SeatType: Codable {
    @Default<Zero>
    var id: Int
    
    var name: String
}

struct StoreItem: Codable {
    var id: Int
    var merchantId: Int
    var name: String
    var type: String
    var address: String
    var status: String // onService, stopService
    var registerTime: Date
    var resources: StoreResources
    var phoneNumbers: [String]
    var seatTypes: [SeatType]
}

struct QueueInfo: Codable {
    @Default<Zero>
    var queueId: Int
    
    @Default<Zero>
    var waitingSize: Int
    
    @Default<Zero>
    var estimateWaitingTime: Int
    
    var seatType: SeatType?
}

struct StoreDetail: Codable {
    var id: Int
    var address: String
    var merchantId: Int
    var name: String
    var type: String
    var status: String // onService, stopService
    var registerTime: Date
    var resources: StoreResources
    var phoneNumbers: [String]
    var seatTypes: [SeatType]
    var queuesInfo: [QueueInfo]
}
