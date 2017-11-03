//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class HelpAuthRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - HelpAuthRouterInput

extension HelpAuthRouter: HelpAuthRouterInput {
    func close() {
        appRouter.backTransition()
    }

    func transitionToConfirmation() {
        appRouter.transition(to: .phone(phone: "", uid: ""))
    }

    func transitionToNewPassword() {
        //appRouter.dropAll()
    }
}
