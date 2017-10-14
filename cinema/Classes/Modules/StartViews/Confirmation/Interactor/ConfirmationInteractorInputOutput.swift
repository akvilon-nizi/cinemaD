//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol ConfirmationInteractorInput {
    func getToken(code: String, uid: String)
    func getCode(uid: String)
}

protocol ConfirmationInteractorOutput: class {
    func successGetToken()
    func faulireGetToken()
}
