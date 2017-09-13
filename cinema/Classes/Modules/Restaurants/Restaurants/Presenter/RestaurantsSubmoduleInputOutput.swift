//
// Created by Александр Масленников on 25.07.17.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol RestaurantsSubmoduleInput {

    func startFetchRestaurants()

    func update(displayItems: [RestaurantsDisplayItem])

    func finishFetchRestaurants(with error: String)
}

protocol RestaurantsSubmoduleOutput {

    func needChangeContentFormat(new: RestaurantsContentFormat)

    func needReloadRestaurants()
}
