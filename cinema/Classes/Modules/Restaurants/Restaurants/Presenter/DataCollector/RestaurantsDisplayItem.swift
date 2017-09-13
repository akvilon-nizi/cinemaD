//
// Created by Xander on 04.09.17.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import CoreLocation

protocol RestaurantsDisplayItem {

    var name: String { get }
    var address: String { get }
    var rating: String { get }
    var image: URL? { get }
    var coordinate: CLLocationCoordinate2D { get }
}

protocol RestaurantsDisplayItemOutput: class {

    func needOpenRestaurant()

    func needCheckTableInRestaurant()
}
