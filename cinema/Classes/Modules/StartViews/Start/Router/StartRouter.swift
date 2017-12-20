//
// Created by akvilon-nizi on 04/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class StartRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - StartRouterInput

extension StartRouter: StartRouterInput {
    func openRegistration() {
        appRouter.transition(to: .registration)
    }
    func openAuth() {
        appRouter.transition(to: .authCinema(isError: false))
    }

    func transitionToMain() {
        OperationQueue.main.addOperation {
            self.appRouter.mainView()
        }
    }
}
