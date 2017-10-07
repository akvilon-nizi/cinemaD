//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class HelpAuthPresenter {

    weak var view: HelpAuthViewInput!
    var interactor: HelpAuthInteractorInput!
    var router: HelpAuthRouterInput!
    weak var output: HelpAuthModuleOutput?
}

// MARK: - HelpAuthViewOutput

extension HelpAuthPresenter: HelpAuthViewOutput {

    func viewIsReady() {
        log.verbose("HelpAuth is ready")
    }

    func backTap() {
        router.close()
    }

    func smsTap() { 
        router.transitionToConfirmation()
    }

    func postTap() {
        router.transitionToNewPassword()
    }
}

// MARK: - HelpAuthInteractorOutput

extension HelpAuthPresenter: HelpAuthInteractorOutput {

}
