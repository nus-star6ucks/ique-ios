//
//  QueueResponse.swift
//  ique
//
//  Created by PCDotFan on 2022/11/2.
//

import Foundation
import DefaultCodable

struct QueueReponse: Codable {
    @Default<Zero>
    var ticketId: Int
    
    @Default<Zero>
    var queueNumber: Int
    
    @Default<Empty>
    var seatTypeName: String
    
    @Default<Zero>
    var waitingSize: Int
    
    @Default<Zero>
    var estimateWaitingTime: Int
}
