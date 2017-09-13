//
// Created by Alexander Maslennikov on 21/07/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class RestaurantsRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - RestaurantsRouterInput

extension RestaurantsRouter: RestaurantsRouterInput {

    func preformTransitionToRestaurantModule(with id: Int) {
        appRouter.transition(to: .restaurant(id: id))
    }
}
