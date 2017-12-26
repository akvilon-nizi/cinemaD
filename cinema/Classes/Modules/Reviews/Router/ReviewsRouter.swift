//
// Created by Danila Lyahomskiy on 28/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class ReviewsRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - ReviewsRouterInput

extension ReviewsRouter: ReviewsRouterInput {
    func close() {
        appRouter.backTransition()
    }

    func home() {
        appRouter.backToMain()
    }
    func openStart() {
        appRouter.dropAll(isError: true)
    }
}
