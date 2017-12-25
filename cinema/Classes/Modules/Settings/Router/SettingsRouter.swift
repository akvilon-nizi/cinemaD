//
// Created by akvilon-nizi on 23/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class SettingsRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - SettingsRouterInput

extension SettingsRouter: SettingsRouterInput {
    func close() {
        appRouter.backTransition()
    }
    func start() {
        appRouter.dropAll(isError: false)
    }
}
