//
//  FullRestaurant.swift
//  cinema
//
//  Created by incetro on 17/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

// MARK: - FullRestaurant

class FullRestaurant: Restaurant {

    let products: [Product]
    let categories: [Category]

    let startTime: String
    let finishTime: String
    let price: Int

    private let productsKey = "liked_products"
    private let categoriesKey = "categories"
    private let startTimeKey = "start_time"
    private let finishTimeKey = "finish_time"
    private let priceKey = "minimal_order"

    required init(map: Map) throws {

        products = try map.value(productsKey)
        categories = try map.value(categoriesKey)
        startTime = try map.value(startTimeKey)
        finishTime = try map.value(finishTimeKey)
        price = try map.value(priceKey)

        try super.init(map: map)
    }
}
