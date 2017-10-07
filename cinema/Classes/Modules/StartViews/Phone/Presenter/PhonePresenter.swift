//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class PhonePresenter {

    weak var view: PhoneViewInput!
    var interactor: PhoneInteractorInput!
    var router: PhoneRouterInput!
    weak var output: PhoneModuleOutput?
}

// MARK: - PhoneViewOutput

extension PhonePresenter: PhoneViewOutput {

    func viewIsReady() {
        log.verbose("Phone is ready")
    }

    func backTap() {
        router.close()
    }

    func next() {
        router.transitionToConfirmation()
    }
}

// MARK: - PhoneInteractorOutput

extension PhonePresenter: PhoneInteractorOutput {

}
