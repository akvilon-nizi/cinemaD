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
    let iWatched: Bool?
    let iWillWatch: Bool?
    let imageUrl: String
    var add: Bool = false
    var delete: Bool = false
    var rate: Double? = 0

    private let idKey = "id"
    private let nameKey = "name"
    private let iWatchedKey = "i_watched"
    private let iWillWatchKey = "i_will_watch"
    private let imageUrlKey = "image_url"
    private let rateKey = "my_rate"

    required init(map: Map) throws {
        id = try map.value(idKey)
        name = try map.value(nameKey)
        iWatched = try? map.value(iWatchedKey)
        iWillWatch = try? map.value(iWillWatchKey)
        imageUrl = try map.value(imageUrlKey)
        rate = try? map.value(rateKey)
    }

    init(id: String, name: String, imageUrl: String, rate: Double = 0) {
        self.id = id
        self.name = name
        iWatched = false
        iWillWatch = false
        self.imageUrl = imageUrl
        self.rate = rate
    }

    func mapping(map: Map) {
        id >>> map[idKey]
        name >>> map[nameKey]
        iWatched >>> map[iWatchedKey]
        iWillWatch >>> map[iWillWatchKey]
        imageUrl >>> map[imageUrlKey]
        rate >>> map[rateKey]
    }
}
