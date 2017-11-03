//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class PasswordPresenter {

    weak var view: PasswordViewInput!
    var interactor: PasswordInteractorInput!
    var router: PasswordRouterInput!
    weak var output: PasswordModuleOutput?
}

// MARK: - PasswordViewOutput

extension PasswordPresenter: PasswordViewOutput {

    func viewIsReady() {
        log.verbose("Password is ready")
    }
}

// MARK: - PasswordInteractorOutput

extension PasswordPresenter: PasswordInteractorOutput {

}
