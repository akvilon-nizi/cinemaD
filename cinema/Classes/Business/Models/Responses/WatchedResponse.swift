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
    let years: [Int]

    private let watchedKey = "watched"
    private let genresKey = "genres"
    private let yearsKey = "years"

    required init(map: Map) throws {
        watched = try map.value(watchedKey)
        genres = try map.value(genresKey)
        years = try map.value(yearsKey)
    }

    func mapping(map: Map) {
        watched >>> map[watchedKey]
        genres >>> map[genresKey]
        years >>> map[yearsKey]
    }
}
