//
// Created by incetro on 12/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class RestaurantMenuRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - RestaurantMenuRouterInput

extension RestaurantMenuRouter: RestaurantMenuRouterInput {

    func openCart() {

        appRouter.transition(to: .cart)
    }
}
