//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class NewPasswordPresenter {

    weak var view: NewPasswordViewInput!
    var interactor: NewPasswordInteractorInput!
    var router: NewPasswordRouterInput!
    weak var output: NewPasswordModuleOutput?
}

// MARK: - NewPasswordViewOutput

extension NewPasswordPresenter: NewPasswordViewOutput {

    func viewIsReady() {
        log.verbose("NewPassword is ready")
    }
}

// MARK: - NewPasswordInteractorOutput

extension NewPasswordPresenter: NewPasswordInteractorOutput {

}
