//
//  WillWatchResponse.swift
//  cinema
//
//  Created by Mac on 30.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class WillWatchResponse: ImmutableMappable {

    let willWatch: [FilmCollections]
    let genres: [String]
    let years: [Int]

    private let willWatchKey = "films"
    private let genresKey = "genres"
    private let yearsKey = "years"

    required init(map: Map) throws {
        willWatch = try map.value(willWatchKey)
        genres = try map.value(genresKey)
        years = try map.value(yearsKey)
    }

    func mapping(map: Map) {
        willWatch >>> map[willWatchKey]
        genres >>> map[genresKey]
        years >>> map[yearsKey]
    }
}
