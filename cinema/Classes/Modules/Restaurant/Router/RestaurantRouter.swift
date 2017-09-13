//
// Created by Alexander Maslennikov on 24/07/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class RestaurantRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - RestaurantRouterInput

extension RestaurantRouter: RestaurantRouterInput {

    func openMenu(selectedCategoryID: Int, restaurant: FullRestaurant) {

        appRouter.transition(to: .restaurantMenu(selectedCategoryID: selectedCategoryID, restaurant: restaurant))
    }
}
