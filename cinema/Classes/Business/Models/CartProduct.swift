//
//  CartProduct.swift
//  foodle
//
//  Created by incetro on 16/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

// MARK: - CartProduct

class CartProduct: ImmutableMappable {

    let cost: Int
    let quantity: Int
    let id: Int
    let image: String
    let name: String
    let price: Int
    let weight: Int

    private let costKey = "cost"
    private let quantityKey = "quantity"
    private let idKey = "id"
    private let imageKey = "image"
    private let nameKey = "name"
    private let priceKey = "price"
    private let weightKey = "weight"

    required init(map: Map) throws {

        cost = try map.value(costKey)
        quantity = try map.value(quantityKey)
        id = try map.value(idKey)
        image = try map.value(imageKey)
        name = try map.value(nameKey)
        price = try map.value(priceKey)
        weight = try map.value(weightKey)
    }
}
