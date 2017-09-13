//
//  Category.swift
//  foodle
//
//  Created by incetro on 13/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

// MARK: - Category

class Category: ImmutableMappable {

    let id: Int
    let name: String

    private let idKey = "id"
    private let nameKey = "name"

    required init(map: Map) throws {
        id = try map.value(idKey)
        name = try map.value(nameKey)
    }

    func mapping(map: Map) {
        id >>> map[idKey]
        name >>> map[nameKey]
    }

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
