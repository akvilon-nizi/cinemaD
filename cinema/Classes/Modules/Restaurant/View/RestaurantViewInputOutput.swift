//
// Created by Alexander Maslennikov on 24/07/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol RestaurantViewInput: class {

    func setupInitialState(withRestaurant restaurant: FullRestaurant)
}

protocol RestaurantViewOutput {

    func viewIsReady()
    func openMenuButtonTapped(selectedCategoryID: Int)
}
