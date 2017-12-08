//
//  Adward.swift
//  cinema
//
//  Created by iOS on 06.12.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class Adward: ImmutableMappable {

    let id: String
    var name: String
    let description: String
    var image: String

    private let idKey = "id"
    private let nameKey = "name"
    private let descriptionKey = "description"
    private let imageKey = "image"

    required init(map: Map) throws {
        id = try map.value(idKey)
        name = try map.value(nameKey)
        description = try map.value(descriptionKey)
        image = try map.value(imageKey)
    }

    func mapping(map: Map) {
        id >>> map[idKey]
        name >>> map[nameKey]
        description >>> map[descriptionKey]
        image >>> map[imageKey]
    }
}
