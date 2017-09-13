//
// Created by Alexander Maslennikov on 25/07/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class RestaurantsMapRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - RestaurantsMapRouterInput

extension RestaurantsMapRouter: RestaurantsMapRouterInput {

    func openLeftMenu() {

        appRouter.transition(to: .profile)
    }
}
