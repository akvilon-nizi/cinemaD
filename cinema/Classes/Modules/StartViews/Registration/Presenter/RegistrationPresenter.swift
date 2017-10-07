//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class RegistrationPresenter {

    weak var view: RegistrationViewInput!
    var interactor: RegistrationInteractorInput!
    var router: RegistrationRouterInput!
    weak var output: RegistrationModuleOutput?
}

// MARK: - RegistrationViewOutput

extension RegistrationPresenter: RegistrationViewOutput {

    func viewIsReady() {
        log.verbose("Registration is ready")
    }

    func backTap() {
        router.close()
    }
}

// MARK: - RegistrationInteractorOutput

extension RegistrationPresenter: RegistrationInteractorOutput {

}
