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
