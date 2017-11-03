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

    private let watchedKey = "watched"

    required init(map: Map) throws {
        watched = try map.value(watchedKey)
    }

    func mapping(map: Map) {
        watched >>> map[watchedKey]
    }
}
