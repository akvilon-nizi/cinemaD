//
//  FullRestaurantResponse.swift
//  cinema
//
//  Created by incetro on 17/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

// MARK: - FullRestaurantResponse

class FullRestaurantResponse: ServerResponse {

    let restaurant: FullRestaurant

    private let restaurantKey = "data"

    required init(map: Map) throws {

        restaurant = try map.value(restaurantKey)

        try super.init(map: map)
    }
}
