//
// Created by incetro on 21/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol AuthCodeInteractorInput {

    func sendSMSCode(phone: String)

    func checkSMSCode(phone: String, code: String, isAuth: Bool)

    var regionWasChosen: Bool { get }
}

protocol AuthCodeInteractorOutput: class {

    func checkSMSCodeSuccess(phone: String)
    func checkSMSCodeFailure(errorMessage: String)

    func sendSMSCodeSuccess(phone: String)
    func sendSMSCodeFailure(errorMessage: String)
}
