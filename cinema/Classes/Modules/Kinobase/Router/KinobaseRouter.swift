//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class KinobaseRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - KinobaseRouterInput

extension KinobaseRouter: KinobaseRouterInput {
    func close() {
        appRouter.backTransition()
    }

    func openAllFilms() {
        appRouter.transition(to: .films)
    }
}
