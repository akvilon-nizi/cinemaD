//
// Created by incetro on 25/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class TermsRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - TermsRouterInput

extension TermsRouter: TermsRouterInput {

    func openRestaurants() {

        appRouter.transition(to: .restaurants)
    }

    func close() {

        appRouter.backTransition()
    }
}
