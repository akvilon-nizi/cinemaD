//
// Created by Alexander Maslennikov on 25/07/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import CoreLocation

protocol RestaurantsMapViewInput: class {

    func updateUserMarker(with coordinate: CLLocationCoordinate2D?)

    func show(displayItems: [RestaurantsDisplayItem])
}

protocol RestaurantsMapViewOutput {

    func viewIsReady()

    func pressListButton()

    func pressMenuButton()
}
