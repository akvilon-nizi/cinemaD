//
// Created by incetro on 25/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol TermsViewInput: class {

    func setupInitialState(withTerms terms: Terms)

}

protocol TermsViewOutput {

    func viewIsReady()
    func didTapConfirmButton()
    func backButtonTapped()
}
