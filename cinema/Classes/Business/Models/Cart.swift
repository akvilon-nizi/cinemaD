//
//  Cart.swift
//  foodle
//
//  Created by incetro on 16/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

// MARK: - Cart

class Cart: ImmutableMappable {

    let count: Int
    let cost: Int
    let weight: Int
    let restaurant: Restaurant?
    let products: [CartProduct]

    private let restaurantKey = "restaurant"
    private let productsKey = "products"
    private let countKey = "count"
    private let costKey = "cost"
    private let weightKey = "weight"

    required init(map: Map) throws {

        restaurant = try? map.value(restaurantKey)
        count = try map.value(countKey)
        cost = try map.value(costKey)
        weight = try map.value(weightKey)
        products = try map.value(productsKey)
    }
}
