//
//  GeoResponse.swift
//  cinema
//
//  Created by iOS on 19.12.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class GeoResponse: ImmutableMappable {

    let awards: [Adward]

    private let awardsKey = "awards"

    required init(map: Map) throws {
        awards = try map.value(awardsKey)
    }

    func mapping(map: Map) {
        awards >>> map[awardsKey]
    }
}
