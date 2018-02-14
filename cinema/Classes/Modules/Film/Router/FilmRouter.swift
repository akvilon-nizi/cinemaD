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

    func home() {
        appRouter.backToMain()
    }

    func openPersonID(_ personID: String, name: String, role: String, persons: [PersonFromFilm]) {
        appRouter.transition(to: .actors(id: personID, name: name, role: role, persons: persons))
    }

    func rewiewsFrom(_ film: FullFilm) {
        appRouter.transition(to: .reviews(film: film))
    }

    func openStart() {
        appRouter.dropAll(isError: true)
    }
}
