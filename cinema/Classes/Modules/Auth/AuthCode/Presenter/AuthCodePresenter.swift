//
// Created by incetro on 21/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class AuthCodePresenter {

    weak var view: AuthCodeViewInput!
    var interactor: AuthCodeInteractorInput!
    var router: AuthCodeRouterInput!
    weak var output: AuthCodeModuleOutput?

    let phone: String
    let needToDismiss: Bool

    init(phone: String, needToDismiss: Bool) {

        self.phone = phone
        self.needToDismiss = needToDismiss
    }
}

// MARK: - AuthCodeViewOutput

extension AuthCodePresenter: AuthCodeViewOutput {

    func viewIsReady() {
        log.verbose("AuthCode is ready")
        view.setupInitialState(withPhone: phone)
    }

    func didEndEditing(code: String) {

        interactor.checkSMSCode(phone: phone, code: code, isAuth: !needToDismiss)
    }

    func retryButtonTapped() {

        interactor.sendSMSCode(phone: phone)
    }

    func closeButtonTapped() {

        router.close()
    }
}

// MARK: - AuthCodeInteractorOutput

extension AuthCodePresenter: AuthCodeInteractorOutput {

    func checkSMSCodeSuccess(phone: String) {

        log.verbose("Finish check sms code")

        if needToDismiss {

            router.close()

        } else {

            if interactor.regionWasChosen {

                router.openRestaurants()

            } else {

                router.openRegion()
            }
        }
    }

    func checkSMSCodeFailure(errorMessage: String) {

        log.error("Check sms code error: \(errorMessage)")
        router.performTransitionToNetworkAlert(message: errorMessage)
    }

    func sendSMSCodeSuccess(phone: String) {

        log.verbose("Finish send sms code")
    }

    func sendSMSCodeFailure(errorMessage: String) {

        log.error("Send sms code error: \(errorMessage)")
        router.performTransitionToNetworkAlert(message: errorMessage)
    }
}
