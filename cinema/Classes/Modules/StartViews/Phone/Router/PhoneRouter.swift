//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class PhoneRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - PhoneRouterInput

extension PhoneRouter: PhoneRouterInput {
    func close() {
        appRouter.backTransition()
    }

    func transitionToConfirmation() {
        appRouter.transition(to: .confirmation)
    }
}
