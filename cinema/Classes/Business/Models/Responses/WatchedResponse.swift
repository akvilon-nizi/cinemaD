//
//  WatchedResponse.swift
//  cinema
//
//  Created by Mac on 30.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class WatchedResponse: ImmutableMappable {

    let watched: [FilmCollections]
    let genres: [String]

    private let watchedKey = "watched"
    private let genresKey = "genres"

    required init(map: Map) throws {
        watched = try map.value(watchedKey)
        genres = try map.value(genresKey)
    }

    func mapping(map: Map) {
        watched >>> map[watchedKey]
        genres >>> map[genresKey]
    }
}
