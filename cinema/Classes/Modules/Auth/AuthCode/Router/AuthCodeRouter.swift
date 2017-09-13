//
// Created by incetro on 21/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class AuthCodeRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - AuthCodeRouterInput

extension AuthCodeRouter: AuthCodeRouterInput {

    func close() {

        appRouter.dismissModule()
    }

    func openRestaurants() {

        appRouter.dismissModule()
        appRouter.transition(to: .restaurants)
    }

    func openRegion() {

        appRouter.dismissModule()
        appRouter.transition(to: .region(selectedRegion: nil, needToReturn: false))
    }
}
