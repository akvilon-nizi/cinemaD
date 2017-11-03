//
// Created by Xander on 04.09.17.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class Formatters {

    class func restaurant(rating: Double) -> String? {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        formatter.roundingMode = .ceiling
        return formatter.string(from: NSNumber(value: rating))
    }
}
