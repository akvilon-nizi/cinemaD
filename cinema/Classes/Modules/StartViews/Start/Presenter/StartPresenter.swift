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
    let isError: Bool

    init(isError: Bool) {
        self.isError = isError
    }

}

// MARK: - StartViewOutput

extension StartPresenter: StartViewOutput {

    func viewIsReady() {
        log.verbose("Start is ready")
        if isError {
            view.showNetworkError(message: L10n.alertAutorizationError)
        }
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

    func getAuthCode(_ authCode: String) {
        interactor.sendData(authCode: authCode)
    }
}

// MARK: - StartInteractorOutput

extension StartPresenter: StartInteractorOutput {
    func authSuccess() {
        router.transitionToMain()
    }

    func faulireAuth() {
        view.getError()
    }
}
