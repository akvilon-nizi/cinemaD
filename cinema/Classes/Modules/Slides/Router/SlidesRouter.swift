//
// Created by DanilaLyahomskiy on 30/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class SlidesRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - SlidesRouterInput

extension SlidesRouter: SlidesRouterInput {

    func openAuth() {
        appRouter.transition(to: .authPhone)
    }
}
