//
// Created by akvilon-nizi on 16/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class RewardsRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - RewardsRouterInput

extension RewardsRouter: RewardsRouterInput {
    func close() {
        appRouter.backTransition()
    }
}
