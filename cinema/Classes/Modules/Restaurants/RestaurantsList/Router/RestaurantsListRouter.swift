//
// Created by Alexander Maslennikov on 25/07/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class RestaurantsListRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - RestaurantsListRouterInput

extension RestaurantsListRouter: RestaurantsListRouterInput {
    func openMyOrder() {
        appRouter.transition(to: .myOrder)
    }
}
