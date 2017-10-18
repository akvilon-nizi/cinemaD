//
//  OrdersTransforms.swift
//  cinema
//
//  Created by Mac on 06.09.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class OrderStatusTransform: TransformType {
    typealias Object = OrderStatusType
    typealias JSON = String

    init() {}

    func transformFromJSON(_ value: Any?) -> OrderStatusType? {
        if let contentTypeString = value as? String {
            return OrderStatusType(rawValue: getRawValue(contentTypeString))
        }
        return nil
    }

    func transformToJSON(_ value: OrderStatusType?) -> String? {
        if let contentType = value {
            return contentType.rawValue
        }
        return nil
    }

    func getRawValue(_ status: String) -> String {
        switch status {
        case "validation":
            return "validation"
        case "validation_twice":
            return "validationTwice"
        case "approved":
            return "approved"
        case "rejected":
            return "rejected"
        case "auto_rejected":
            return "autoRejected"
        case "auto_rejected_twice":
            return "autoRejectedTwice"
        case "paid":
            return "paid"
        case "error_pay":
            return "errorPay"
        case "completed":
            return "completed"
        case "canceled_by_user":
            return "canceledByUser"
        case "auto_rejected_booking":
            return "autoRejectedBooking"
        default:
            return "canceledByRestaurant"
        }
    }
}

class OrderTypeTransform: TransformType {
    typealias Object = OrderType
    typealias JSON = String

    init() {}

    func transformFromJSON(_ value: Any?) -> OrderType? {
        if let contentTypeString = value as? String {
            return OrderType(rawValue: contentTypeString)
        }
        return nil
    }

    func transformToJSON(_ value: OrderType?) -> String? {
        if let contentType = value {
            return contentType.rawValue
        }
        return nil
    }
}
