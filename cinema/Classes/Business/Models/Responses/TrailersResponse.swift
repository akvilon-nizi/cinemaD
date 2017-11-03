//
//  TrailersResponse.swift
//  cinema
//
//  Created by User on 17.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class TrailersResponse: ImmutableMappable {

    let trailers: [String]

    private let trailersKey = "trailers"

    required init(map: Map) throws {
        trailers = try map.value(trailersKey)
    }

    func mapping(map: Map) {
        trailers >>> map[trailersKey]
    }
}
