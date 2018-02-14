//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class ActorsRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - ActorsRouterInput

extension ActorsRouter: ActorsRouterInput {
    func close() {
        appRouter.backTransition()
    }

    func home() {
        appRouter.backToMain()
    }

    func openPersonID(_ personID: String, name: String, role: String, persons: [PersonFromFilm]) {
        appRouter.transition(to: .actors(id: personID, name: name, role: role, persons: persons))
    }

    func openFilm(videoId: String, name: String) {
        appRouter.transition(to: .film(videoID: videoId, name: name))
    }

    func openStart() {
        appRouter.dropAll(isError: true)
    }
}
