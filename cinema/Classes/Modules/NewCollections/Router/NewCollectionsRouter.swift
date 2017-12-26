//
// Created by akvilon-nizi on 31/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class NewCollectionsRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - NewCollectionsRouterInput

extension NewCollectionsRouter: NewCollectionsRouterInput {
    func close() {
        appRouter.backTransition()
    }

    func openStart() {
        appRouter.dropAll(isError: true)
    }
}
