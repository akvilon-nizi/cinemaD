//
//  TodayAwards.swift
//  cinema
//
//  Created by User on 17.12.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class TodayAwards: ImmutableMappable {

//    "id": "582f74f4-7b3d-4917-bc4b-004402bc5bf7",
//    "type": "geo",
//    "name": "новая награда",
//    "description": "описание награды",
//    "image_url": "https://cinemad.pr-solution.ru/uploads/default/no_poster.png"

    let id: String
    let name: String
    let imageUrl: String
    let description: String
    let type: String

    private let idKey = "id"
    private let nameKey = "name"
    private let imageUrlKey = "image_url"
    private let descriptionKey = "description"
    private let typeKey = "type"

    required init(map: Map) throws {
        id = try map.value(idKey)
        name = try map.value(nameKey)
        imageUrl = try map.value(imageUrlKey)
        description = try map.value(descriptionKey)
        type = try map.value(typeKey)
    }

    func mapping(map: Map) {
        id >>> map[idKey]
        name >>> map[nameKey]
        imageUrl >>> map[imageUrlKey]
        description >>> map[descriptionKey]
        type >>> map[typeKey]
    }
}
