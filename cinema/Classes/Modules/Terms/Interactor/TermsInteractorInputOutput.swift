//
// Created by incetro on 25/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol TermsInteractorInput {

    func obtainTerms()

    func setConfirmed()
}

protocol TermsInteractorOutput: class {

    func obtainTermsSuccess(terms: Terms)
    func obtainTermsFailure(errorMessage: String)
}
