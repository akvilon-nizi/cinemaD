//
//  FilmCollections.swift
//  cinema
//
//  Created by Mac on 30.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class FilmCollections: ImmutableMappable {

    let id: String
    let name: String
    let imageUrl: String
    let nameOriginal: String
//    let userCollections: [String]

    private let idKey = "id"
    private let nameKey = "name"
    private let imageUrlKey = "image_url"
    private let nameOriginalKey = "name_original"
//    private let userCollectionsKey = "user_collections"

    required init(map: Map) throws {
        id = try map.value(idKey)
        name = try map.value(nameKey)
        nameOriginal = try map.value(nameOriginalKey)
        imageUrl = try map.value(imageUrlKey)
//        userCollections = try map.value(userCollectionsKey)
    }

    func mapping(map: Map) {
        id >>> map[idKey]
        name >>> map[nameKey]
        nameOriginal >>> map[nameOriginalKey]
        imageUrl >>> map[imageUrlKey]
//        userCollections >>> map[userCollectionsKey]
    }
}
