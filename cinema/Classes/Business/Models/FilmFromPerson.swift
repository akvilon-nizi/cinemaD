//
//  FilmFromPerson.swift
//  cinema
//
//  Created by User on 17.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class FilmFromPerson: ImmutableMappable {

    let id: String
    let name: String
    let relation: String
    let imageUrl: String

    private let idKey = "id"
    private let nameKey = "name"
    private let relationKey = "relation"
    private let imageUrlKey = "image_url"

    required init(map: Map) throws {
        id = try map.value(idKey)
        name = try map.value(nameKey)
        relation = try map.value(relationKey)
        imageUrl = try map.value(imageUrlKey)
    }

    func mapping(map: Map) {
        id >>> map[idKey]
        name >>> map[nameKey]
        relation >>> map[relationKey]
        imageUrl >>> map[imageUrlKey]
    }
}
