//
//  TicketItem.swift
//  ique
//
//  Created by PCDotFan on 2022/10/31.
//

import Foundation

struct TicketItem: Codable {
    var customerId: Int
    var endTime: Date
    var queueId: Int
    var queueNumber: Int
    var seatType: SeatType
    var startTime: Date
    var status: String
    var storeId: Int
    var ticketId: Int
}
