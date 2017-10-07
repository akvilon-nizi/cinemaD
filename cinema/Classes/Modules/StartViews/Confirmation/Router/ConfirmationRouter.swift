//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class ConfirmationRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - ConfirmationRouterInput

extension ConfirmationRouter: ConfirmationRouterInput {
    func close() {
        appRouter.backTransition()
    }

    func transitionToAuth() {
        appRouter.transition(to: .authCinema)
    }

    func transitionToNewPassword() {
        appRouter.transition(to: .newPassword)
    }
}
