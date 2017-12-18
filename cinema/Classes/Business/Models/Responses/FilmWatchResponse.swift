//
//  FilmWatchResponse.swift
//  cinema
//
//  Created by User on 05.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class FilmWatchResponse: ImmutableMappable {

    let rate: Double

    private let rateKey = "my_rate"

    required init(map: Map) throws {
        rate = try map.value(rateKey)
    }

    func mapping(map: Map) {
        rate >>> map[rateKey]
    }
}
