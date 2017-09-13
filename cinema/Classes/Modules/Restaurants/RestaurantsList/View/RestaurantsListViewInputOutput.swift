//
// Created by Alexander Maslennikov on 25/07/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol RestaurantsListViewInput: class {

    func update(displayItems: [RestaurantsDisplayItem])

    func showEmptyLoading()

    func show(error: String)
}

protocol RestaurantsListViewOutput {

    func viewIsReady()

    func pressMapButton()

    func pressMenuButton()

    func needRetryFetchRestaurants()
}
