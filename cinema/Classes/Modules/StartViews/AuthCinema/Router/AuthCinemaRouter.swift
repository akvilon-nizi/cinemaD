//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class AuthCinemaRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - AuthCinemaRouterInput

extension AuthCinemaRouter: AuthCinemaRouterInput {
    func close() {
        appRouter.backTransition()
    }

    func transitionToHelpAuth() {
        appRouter.transition(to: .helpAuth)
    }

    func transitionToMain() {
        appRouter.mainView()
    }

}
