//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class FilmRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - FilmRouterInput

extension FilmRouter: FilmRouterInput {
    func close() {
        appRouter.backTransition()
    }
}
