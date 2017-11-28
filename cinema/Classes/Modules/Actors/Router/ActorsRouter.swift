//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class ActorsRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - ActorsRouterInput

extension ActorsRouter: ActorsRouterInput {
    func close() {
        appRouter.backTransition()
    }

    func home() {
        appRouter.backToMain()
    }
}
