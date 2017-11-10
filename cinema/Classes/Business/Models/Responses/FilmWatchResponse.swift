//
//  FilmWatchResponse.swift
//  cinema
//
//  Created by User on 05.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class FilmWatchResponse: FilmResponse {

    let rate: Double

    private let rateKey = "rate"

    required init(map: Map) throws {
        rate = try map.value(rateKey)
        try super.init(map: map)
    }

    override func mapping(map: Map) {
        super.mapping(map: map)
        rate >>> map[rateKey]
    }
}
