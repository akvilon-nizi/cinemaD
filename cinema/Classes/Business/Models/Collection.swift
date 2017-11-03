//
//  Collection.swift
//  cinema
//
//  Created by User on 01.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class Collection: ImmutableMappable {

    let id: String
    let name: String
    let films: [FilmCollections]?

    private let idKey = "id"
    private let nameKey = "name"
    private let filmsKey = "films"

    required init(map: Map) throws {
        id = try map.value(idKey)
        name = try map.value(nameKey)
        films = try? map.value(filmsKey)
    }

    func mapping(map: Map) {
        id >>> map[idKey]
        name >>> map[nameKey]
        films >>> map[filmsKey]
    }
}
