//
//  PersonFromFilm.swift
//  cinema
//
//  Created by User on 17.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class PersonFromFilm: ImmutableMappable {

    let id: String
    let name: String
    let imageUrl: String?
    let relation: String

    private let idKey = "id"
    private let nameKey = "name"
    private let imageUrlKey = "image_url"
    private let relationKey = "relation"

    required init(map: Map) throws {
        id = try map.value(idKey)
        name = try map.value(nameKey)
        imageUrl = try? map.value(imageUrlKey)
        relation = try map.value(relationKey)
    }

    func mapping(map: Map) {
        id >>> map[idKey]
        name >>> map[nameKey]
        imageUrl >>> map[imageUrlKey]
        relation >>> map[relationKey]
    }
}
