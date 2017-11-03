//
// Created by akvilon-nizi on 04/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class StartPresenter {

    weak var view: StartViewInput!
    var interactor: StartInteractorInput!
    var router: StartRouterInput!
    weak var output: StartModuleOutput?
}

// MARK: - StartViewOutput

extension StartPresenter: StartViewOutput {

    func viewIsReady() {
        log.verbose("Start is ready")
    }

    func authFromFb() {

    }

    func authFromFbVk() {

    }

    func auth() {
        router.openAuth()
    }

    func registration() {
        router.openRegistration()
    }
}

// MARK: - StartInteractorOutput

extension StartPresenter: StartInteractorOutput {

}
