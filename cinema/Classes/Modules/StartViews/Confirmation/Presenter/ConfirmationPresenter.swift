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
    let uid: String

    init(uid: String) {
        self.uid = uid
    }
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
//        router.transitionToNewPassword()
    }

    func auth() {
        router.transitionToAuth()
    }

    func sendCode(code: String) {
        interactor.getToken(code: code, uid: uid)
    }
}

// MARK: - ConfirmationInteractorOutput

extension ConfirmationPresenter: ConfirmationInteractorOutput {
    func successGetToken() {
        router.transitionToMain()
    }
    func faulireGetToken() {
        view.showNetworkError()
    }
}
