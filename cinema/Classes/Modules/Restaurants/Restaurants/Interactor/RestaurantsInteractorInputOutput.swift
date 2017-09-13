//
// Created by Alexander Maslennikov on 21/07/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import CoreLocation

protocol RestaurantsInteractorInput {

    var coordinate: CLLocationCoordinate2D? { get }

    func startFetchingUserLocation()

    func fetchRestaurants()
}

protocol RestaurantsInteractorOutput: class {

    func successFetch(restaurants: [Restaurant])

    func finishFetchRestaurants(errorMessage: String)

    func needUpdate(coordinate: CLLocationCoordinate2D?)
}
