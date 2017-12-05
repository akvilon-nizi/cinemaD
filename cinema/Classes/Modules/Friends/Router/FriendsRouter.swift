//
// Created by Danila Lyahomskiy on 05/12/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class FriendsRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - FriendsRouterInput

extension FriendsRouter: FriendsRouterInput {
    func close() {
        appRouter.backTransition()
    }

    func home() {
        appRouter.backToMain()
    }
}
