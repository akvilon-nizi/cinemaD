//
// Created by Alexander Maslennikov on 25/07/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import CoreLocation

protocol RestaurantsMapModuleInput: RestaurantsSubmoduleInput {

    func update(userCoordinate: CLLocationCoordinate2D?)
}

protocol RestaurantsMapModuleOutput: class, RestaurantsSubmoduleOutput {

    var mapInput: RestaurantsMapModuleInput? { get set }
}
