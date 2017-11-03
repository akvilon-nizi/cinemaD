//
//  CollectionWithFilm.swift
//  cinema
//
//  Created by User on 01.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class CollectionWithFilm: ImmutableMappable {

    let id: String
    let name: String

    private let idKey = "id"
    private let nameKey = "name"

    required init(map: Map) throws {
        id = try map.value(idKey)
        name = try map.value(nameKey)
    }

    init(id: String, name: String, imageUrl: String) {
        self.id = id
        self.name = name
    }

    func mapping(map: Map) {
        id >>> map[idKey]
        name >>> map[nameKey]
    }
}
