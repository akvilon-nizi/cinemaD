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
    let imageUrl: String?
    let description: String?

    private let idKey = "id"
    private let nameKey = "name"
    private let filmsKey = "films"
    private let imageUrlKey = "image_url"
    private let descriptionKey = "description"

    required init(map: Map) throws {
        id = try map.value(idKey)
        name = try map.value(nameKey)
        films = try? map.value(filmsKey)
        imageUrl = try? map.value(imageUrlKey)
        description = try? map.value(descriptionKey)
    }

    func mapping(map: Map) {
        id >>> map[idKey]
        name >>> map[nameKey]
        films >>> map[filmsKey]
        imageUrl >>> map[imageUrlKey]
        description >>> map[descriptionKey]
    }
}
