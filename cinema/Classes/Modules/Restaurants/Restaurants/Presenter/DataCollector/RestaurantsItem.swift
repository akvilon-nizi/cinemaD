//
// Created by Xander on 04.09.17.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import CoreLocation

protocol RestaurantsItemOutput: class {

    func needOpenRestaurant(with id: Int)

    func needCheckTableInRestaurant(with id: Int)
}

class RestaurantsItem: RestaurantsDisplayItem {

    private(set) var name: String
    private(set) var address: String
    private(set) var rating: String
    private(set) var image: URL?
    private(set) var coordinate: CLLocationCoordinate2D

    fileprivate let restaurant: Restaurant
    fileprivate weak var output: RestaurantsItemOutput?

    init(restaurant: Restaurant, output: RestaurantsItemOutput?) {
        self.restaurant = restaurant
        self.output = output

        name = restaurant.name
        address = restaurant.address
        rating = Formatters.restaurant(rating: restaurant.rating) ?? ""
        image = URL(string: restaurant.image)
        coordinate = CLLocationCoordinate2D(latitude: restaurant.lat, longitude: restaurant.long)
    }
}

// MARK: - RestaurantsDisplayItemOutput

extension RestaurantsItem: RestaurantsDisplayItemOutput {

    func needOpenRestaurant() {
        output?.needOpenRestaurant(with: restaurant.id)
    }

    func needCheckTableInRestaurant() {
        output?.needCheckTableInRestaurant(with: restaurant.id)
    }
}
