//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class FilmsRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - FilmsRouterInput

extension FilmsRouter: FilmsRouterInput {
    func close() {
        appRouter.backTransition()
    }

    func home() {
        appRouter.backToMain()
    }

    func openFilm(videoId: String, name: String) {
        appRouter.transition(to: .film(videoID: videoId, name: name))
    }

    func openStart() {
        appRouter.dropAll(isError: true)
    }
}
