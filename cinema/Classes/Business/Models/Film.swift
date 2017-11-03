//
//  Film.swift
//  cinema
//
//  Created by User on 16.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class Film: ImmutableMappable {

    let id: String
    let name: String
    let iWatched: Bool
    let iWillWatch: Bool
    let imageUrl: String
    var add: Bool = false
    var delete: Bool = false

    private let idKey = "id"
    private let nameKey = "name"
    private let iWatchedKey = "i_watched"
    private let iWillWatchKey = "i_will_watch"
    private let imageUrlKey = "image_url"

    required init(map: Map) throws {
        id = try map.value(idKey)
        name = try map.value(nameKey)
        iWatched = try map.value(iWatchedKey)
        iWillWatch = try map.value(iWillWatchKey)
        imageUrl = try map.value(imageUrlKey)
    }

    init(id: String, name: String, imageUrl: String) {
        self.id = id
        self.name = name
        iWatched = false
        iWillWatch = false
        self.imageUrl = imageUrl
    }

    func mapping(map: Map) {
        id >>> map[idKey]
        name >>> map[nameKey]
        iWatched >>> map[iWatchedKey]
        iWillWatch >>> map[iWillWatchKey]
        imageUrl >>> map[imageUrlKey]
    }
}
