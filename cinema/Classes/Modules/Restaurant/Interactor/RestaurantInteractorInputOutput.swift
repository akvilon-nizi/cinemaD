//
// Created by Alexander Maslennikov on 24/07/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol RestaurantInteractorInput {

    func obtainRestaurant(byRestaurantID restaurantID: Int)
}

protocol RestaurantInteractorOutput: class {

    func obtainRestaurantSuccess(restaurant: FullRestaurant)
    func obtainRestaurantFailure(errorMessage: String)
}
