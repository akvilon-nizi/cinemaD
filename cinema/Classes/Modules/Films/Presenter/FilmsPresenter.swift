//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class FilmsPresenter {

    weak var view: FilmsViewInput!
    var interactor: FilmsInteractorInput!
    var router: FilmsRouterInput!
    weak var output: FilmsModuleOutput?
    var films: [Film]!
}

// MARK: - FilmsViewOutput

extension FilmsPresenter: FilmsViewOutput {
    func homeButtonTap() {
        router.home()
    }

    func viewIsReady() {
        log.verbose("Films is ready")
        view.setupInitialState(films)
    }

    func backButtonTap() {
        router.close()
    }

    func openFilmID(_ filmId: String, name: String) {
        router.openFilm(videoId: filmId, name: name)
    }
}

// MARK: - FilmsInteractorOutput

extension FilmsPresenter: FilmsInteractorOutput {
    func tokenError() {
        router.openStart()
    }

    func getError() {

    }
    func getFilms(films: [Film]) {
    }
}
