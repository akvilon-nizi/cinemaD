//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class AuthCinemaPresenter {

    weak var view: AuthCinemaViewInput!
    var interactor: AuthCinemaInteractorInput!
    var router: AuthCinemaRouterInput!
    weak var output: AuthCinemaModuleOutput?
}

// MARK: - AuthCinemaViewOutput

extension AuthCinemaPresenter: AuthCinemaViewOutput {

    func viewIsReady() {
        log.verbose("AuthCinema is ready")
    }

    func backTap() {
        router.close()
    }

    func helpAuth() {
        router.transitionToHelpAuth()
    }

    func auth(phone: String, password: String) {
        interactor.sendData(password: password, phone: phone)
    }
}

// MARK: - AuthCinemaInteractorOutput

extension AuthCinemaPresenter: AuthCinemaInteractorOutput {
    func authSeccess() {
        router.transitionToMain()
    }
    func faulireAuth() {
        view.showNetworkError()
    }
}
