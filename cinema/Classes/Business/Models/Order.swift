//
//  Order.swift
//  foodle
//
//  Created by Mac on 06.09.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

enum OrderStatusType: String {
    case validation
    case validationTwice
    case approved
    case rejected
    case autoRejected
    case autoRejectedTwice
    case paid
    case errorPay
    case completed
    case canceledByUser
    case canceledByRestaurant
    case autoRejectedBooking
}

enum OrderType: String {
    case booking
    case export
}

class Order: ImmutableMappable {

    let id: Int
    let number: String
    let restaurant: Restaurant
    let date: Date
    let persons: Int
    let cost: Int
    let type: OrderType
    let status: OrderStatusType

    private let idKey = "id"
    private let numberKey = "number"
    private let restaurantKey = "restaurant"
    private let dateKey = "visit_at"
    private let personsKey = "persons"
    private let costKey = "cost"
    private let typeKey = "type"
    private let statusKey = "status"

    required init(map: Map) throws {
        id = try map.value(idKey)
        number = try map.value(numberKey)
        restaurant = try map.value(restaurantKey)
        date = try map.value(dateKey, using: DateTransform())
        persons = try map.value(personsKey)
        cost = try map.value(costKey)
        type = try map.value(typeKey, using: OrderTypeTransform())
        status = try map.value(statusKey, using: OrderStatusTransform())
    }

    func mapping(map: Map) {
        id >>> map[idKey]
        number >>> map[numberKey]
        restaurant >>> map[restaurantKey]
        date >>> (map[dateKey], DateTransform())
        persons >>> map[personsKey]
        cost >>> map[costKey]
        type >>> (map[typeKey], OrderTypeTransform())
        status >>> (map[statusKey], OrderStatusTransform())
    }
}
