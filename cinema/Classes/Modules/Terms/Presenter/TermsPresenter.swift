//
// Created by incetro on 25/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class TermsPresenter {

    weak var view: TermsViewInput!
    var interactor: TermsInteractorInput!
    var router: TermsRouterInput!
    weak var output: TermsModuleOutput?
}

// MARK: - TermsViewOutput

extension TermsPresenter: TermsViewOutput {

    func viewIsReady() {
        log.verbose("Terms is ready")
        interactor.obtainTerms()
    }

    func didTapConfirmButton() {

        interactor.setConfirmed()
        router.openRestaurants()
    }

    func backButtonTapped() {

        router.close()
    }
}

// MARK: - TermsInteractorOutput

extension TermsPresenter: TermsInteractorOutput {

    func obtainTermsSuccess(terms: Terms) {

        view.setupInitialState(withTerms: terms)
    }

    func obtainTermsFailure(errorMessage: String) {

        log.error("Finish fetch terms with error: \(errorMessage)")
        router.performTransitionToNetworkAlert(message: errorMessage)
    }
}
