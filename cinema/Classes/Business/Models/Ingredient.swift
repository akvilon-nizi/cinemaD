//
//  Ingredient.swift
//  foodle
//
//  Created by Mac on 04.09.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

// MARK: - Ingredient

class Ingredient: ImmutableMappable {

    let id: Int
    let name: String

    private let idKey = "id"
    private let nameKey = "name"

    required init(map: Map) throws {
        id = try map.value(idKey)
        name = try map.value(nameKey)
    }

}
