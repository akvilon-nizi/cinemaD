//
//  RegionResponse.swift
//  foodle
//
//  Created by incetro on 24/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

// MARK: - RegionResponse

class RegionResponse: ServerResponse {

    var regions: [Region]

    private let regionsKey = "data"

    required init(map: Map) throws {
        regions = try map.value(regionsKey)

        try super.init(map: map)
    }
}
