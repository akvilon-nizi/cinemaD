//
//  Region.swift
//  foodle
//
//  Created by incetro on 24/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

// MARK: - Region

class Region: ImmutableMappable {

    let id: Int
    let name: String
    let icon: String
    let lat: Double
    let long: Double

    private let idKey = "id"
    private let nameKey = "name"
    private let iconKey = "icon"
    private let latKey = "lat"
    private let longKey = "long"

    required init(map: Map) throws {

        id = try map.value(idKey)
        name = try map.value(nameKey)
        icon = try map.value(iconKey)
        lat = try map.value(latKey)
        long = try map.value(longKey)
    }

    func mapping(map: Map) {

        id >>> map[idKey]
        name >>> map[nameKey]
        icon >>> map[iconKey]
        lat >>> map[latKey]
        long >>> map[longKey]
    }
}
