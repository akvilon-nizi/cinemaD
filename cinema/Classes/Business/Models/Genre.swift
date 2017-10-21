//
//  genre.swift
//  cinema
//
//  Created by User on 17.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class Genre: ImmutableMappable {

    let id: String
    let name: String?

    private let idKey = "id"
    private let nameKey = "name"

    required init(map: Map) throws {
        id = try map.value(idKey)
        name = try? map.value(nameKey)
    }

    func mapping(map: Map) {
        id >>> map[idKey]
        name >>> map[nameKey]
    }
}
