//
// Created by akvilon-nizi on 04/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol StartInteractorInput {
    func sendData(authCode: String)
}

protocol StartInteractorOutput: class {
    func authSuccess()
    func faulireAuth()
}
