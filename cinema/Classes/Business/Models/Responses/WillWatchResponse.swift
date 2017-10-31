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

    private let willWatchKey = "will_watch"

    required init(map: Map) throws {
        willWatch = try map.value(willWatchKey)
    }

    func mapping(map: Map) {
        willWatch >>> map[willWatchKey]
    }
}
