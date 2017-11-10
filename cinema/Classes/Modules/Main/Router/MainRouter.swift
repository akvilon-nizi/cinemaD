//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class MainRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - MainRouterInput

extension MainRouter: MainRouterInput {
    func openFilm(videoId: String, name: String) {
        appRouter.transition(to: .film(videoID: videoId, name: name))
    }

    func openKinobase() {
        appRouter.transition(to: .kinobase)
    }

    func openStart() {
        appRouter.starting()
    }
}
