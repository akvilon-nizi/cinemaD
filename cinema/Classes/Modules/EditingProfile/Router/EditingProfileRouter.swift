//
// Created by akvilon-nizi on 24/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class EditingProfileRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - EditingProfileRouterInput

extension EditingProfileRouter: EditingProfileRouterInput {
    func close() {
        appRouter.backTransition()
    }

    func home() {
        appRouter.backToMain()
    }

    func openStart() {
        appRouter.dropAll(isError: true)
    }
}
