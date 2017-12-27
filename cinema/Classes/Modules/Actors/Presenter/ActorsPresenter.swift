//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class ActorsPresenter {

    weak var view: ActorsViewInput!
    var interactor: ActorsInteractorInput!
    var router: ActorsRouterInput!
    weak var output: ActorsModuleOutput?
    var id: String!
}

// MARK: - ActorsViewOutput

extension ActorsPresenter: ActorsViewOutput {

    func openPersonID(_ personID: String, name: String, role: String, persons: [PersonFromFilm]) {
        router.openPersonID(personID, name: name, role: role, persons: persons)
    }

    func openFilmID(_ filmId: String, name: String) {
        router.openFilm(videoId: filmId, name: name)
    }

    func viewIsReady() {
        log.verbose("Actors is ready")
        interactor.getPersonInfo(id: id)
    }

    func homeButtonTap() {
        router.home()
    }

    func backButtonTap() {
        router.close()
    }

    func tokenError() {
        router.openStart()
    }
}

// MARK: - ActorsInteractorOutput

extension ActorsPresenter: ActorsInteractorOutput {
    func getError() {
        view.showNetworkError()
    }
    func getPersonInfo(person: FullPerson) {
        view.getPersonInfo(person: person)
    }
}
