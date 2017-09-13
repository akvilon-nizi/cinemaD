//
// Created by Xander on 04.09.17.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class RestaurantsDataCollector {

    var restaurants: [Restaurant] = []
    var displayItems: [RestaurantsDisplayItem] = []

    fileprivate weak var itemOutput: RestaurantsItemOutput?

    init(itemOutput: RestaurantsItemOutput?) {
        self.itemOutput = itemOutput
    }

    func update(restaurants: [Restaurant]) {
        self.restaurants = restaurants

        displayItems = restaurants.map {
            RestaurantsItem(restaurant: $0, output: itemOutput)
        }
    }
}
