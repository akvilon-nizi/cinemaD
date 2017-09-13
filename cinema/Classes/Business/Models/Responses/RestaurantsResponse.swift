//
// Created by Александр Масленников on 08.08.17.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class RestaurantsResponse: ServerResponse {

    var restaurants: [Restaurant]

    private let restaurantsKey = "data"

    required init(map: Map) throws {
        restaurants = try map.value(restaurantsKey)

        try super.init(map: map)
    }

    override func mapping(map: Map) {
        restaurants >>> map[restaurantsKey]

        super.mapping(map: map)
    }
}
