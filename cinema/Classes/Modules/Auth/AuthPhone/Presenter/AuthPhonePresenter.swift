//
// Created by Alexander Maslennikov on 04/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class AuthPhonePresenter {

    weak var view: AuthPhoneViewInput!
    var interactor: AuthPhoneInteractorInput!
    var router: AuthPhoneRouterInput!
    weak var output: AuthPhoneModuleOutput?

    var currentPhone: String?
}

// MARK: - AuthPhoneViewOutput

extension AuthPhonePresenter: AuthPhoneViewOutput {

    func viewIsReady() {
        log.verbose("AuthPhone is ready")
    }

    func didEndEditing(phone: String) {
        currentPhone = phone

        log.verbose("Did end editing phone: \(phone)")
        interactor.sendSMSCode(phone: phone)
    }
}

// MARK: - AuthPhoneInteractorOutput

extension AuthPhonePresenter: AuthPhoneInteractorOutput {

    func finishSendSMSCode(phone: String, errorMessage: String?) {
        if let error = errorMessage {
            log.error("Send sms code error: \(error)")
            router.performTransitionToNetworkAlert(message: error)
            return
        }

        log.verbose("Finish send sms code")

        router.openAuthCode(withPhone: phone)
    }
}
