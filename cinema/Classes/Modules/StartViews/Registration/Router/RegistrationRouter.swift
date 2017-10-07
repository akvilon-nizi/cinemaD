//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class RegistrationRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - RegistrationRouterInput

extension RegistrationRouter: RegistrationRouterInput {
    func close() {
        appRouter.backTransition()
    }
}
