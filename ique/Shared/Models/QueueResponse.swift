//
//  QueueResponse.swift
//  ique
//
//  Created by PCDotFan on 2022/11/2.
//

import Foundation

struct QueueReponse: Codable {
    var ticketId: Int
    var queueNumber: Int
    var seatTypeName: String
    var waitingSize: Int
    var estimateWaitingTime: Int
}
