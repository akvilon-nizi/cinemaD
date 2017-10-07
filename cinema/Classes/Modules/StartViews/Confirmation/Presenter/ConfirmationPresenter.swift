//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class ConfirmationPresenter {

    weak var view: ConfirmationViewInput!
    var interactor: ConfirmationInteractorInput!
    var router: ConfirmationRouterInput!
    weak var output: ConfirmationModuleOutput?
}

// MARK: - ConfirmationViewOutput

extension ConfirmationPresenter: ConfirmationViewOutput {

    func viewIsReady() {
        log.verbose("Confirmation is ready")
    }

    func back() {
        router.close()
    }

    func repeatCode() {

    }

    func next() {
        router.transitionToNewPassword()
    }

    func auth() {
        router.transitionToAuth()
    }
}

// MARK: - ConfirmationInteractorOutput

extension ConfirmationPresenter: ConfirmationInteractorOutput {

}
