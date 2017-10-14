//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol RegistrationInteractorInput {
    func sendRegInfo(password: String, name: String, phone: String, phoneIn: String)
}

protocol RegistrationInteractorOutput: class {
    func getUid(uid: String, phone: String)

    func getError()
}
