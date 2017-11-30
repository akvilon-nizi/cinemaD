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

    func rewiewsFromID(_ filmID: String, name: String, genres: String) {
        appRouter.transition(to: .reviews(filmID: filmID, name: name, genres: genres))
    }
}
