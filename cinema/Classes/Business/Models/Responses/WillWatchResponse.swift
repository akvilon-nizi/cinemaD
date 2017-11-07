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

    private let willWatchKey = "will_watch"
    private let genresKey = "genres"

    required init(map: Map) throws {
        willWatch = try map.value(willWatchKey)
        genres = try map.value(genresKey)
    }

    func mapping(map: Map) {
        willWatch >>> map[willWatchKey]
        genres >>> map[genresKey]
    }
}
