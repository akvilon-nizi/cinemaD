//
//  OrdersResponse.swift
//  foodle
//
//  Created by Mac on 06.09.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class OrdersResponse: ServerResponse {

    var orders: [Order]

    private let ordersKey = "data"

    required init(map: Map) throws {
        orders = try map.value(ordersKey)

        try super.init(map: map)
    }

    override func mapping(map: Map) {
        orders >>> map[ordersKey]

        super.mapping(map: map)
    }
}
