//
//  Product.swift
//  cinema
//
//  Created by incetro on 13/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

// MARK: - Product

class Product: ImmutableMappable {

    let id: Int
    let image: String
    let name: String
    let price: Int
    let weight: Int
    let quantityInCart: Int
    let ingredients: [Ingredient]?

    private let idKey = "id"
    private let imageKey = "image"
    private let nameKey = "name"
    private let priceKey = "price"
    private let weightKey = "weight"
    private let quantityInCartKey = "quantity_in_cart"
    private let ingredientsKey = "ingredients"

    required init(map: Map) throws {

        id = try map.value(idKey)
        image = try map.value(imageKey)
        name = try map.value(nameKey)
        price = try map.value(priceKey)
        weight = try map.value(weightKey)
        quantityInCart = try map.value(quantityInCartKey)
        ingredients = try? map.value(ingredientsKey)
    }

    init(id: Int, image: String, name: String, price: Int, weight: Int, quantityInCart: Int) {

        self.id = id
        self.image = image
        self.name = name
        self.price = price
        self.weight = weight
        self.quantityInCart = quantityInCart
        self.ingredients = []
    }
}
