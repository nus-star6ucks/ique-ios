//
//  utils.swift
//  ique
//
//  Created by PCDotFan on 2022/10/31.
//

import Foundation
import Alamofire


extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
