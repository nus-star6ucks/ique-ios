//
//  utils.swift
//  ique
//
//  Created by PCDotFan on 2022/10/31.
//

import SwiftUI
import Foundation
import Alamofire


extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

extension Date {
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}

var primaryColor = Color(red: 0.06274509803921569, green: 0.7254901960784313, blue: 0.5058823529411764)
