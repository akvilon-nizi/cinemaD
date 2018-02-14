//
// Created by Danila Lyahomskiy on 11/12/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class AdminCollectionRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - AdminCollectionRouterInput

extension AdminCollectionRouter: AdminCollectionRouterInput {
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
