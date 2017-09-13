//
// Created by incetro on 24/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class RegionRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - RegionRouterInput

extension RegionRouter: RegionRouterInput {

    func openTerms() {

        appRouter.transition(to: .terms)
    }

    func close() {

        appRouter.backTransition()
    }
}
