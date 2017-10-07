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
}

// MARK: - ActorsViewOutput

extension ActorsPresenter: ActorsViewOutput {

    func viewIsReady() {
        log.verbose("Actors is ready")
    }
}

// MARK: - ActorsInteractorOutput

extension ActorsPresenter: ActorsInteractorOutput {

}
