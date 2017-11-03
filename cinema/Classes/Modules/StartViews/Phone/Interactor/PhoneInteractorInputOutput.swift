//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol PhoneInteractorInput {
    func sendSms(phone: String, phoneCorrect: String)
    func sendUid(uid: String)
}

protocol PhoneInteractorOutput: class {
    func getUid(phone: String, uid: String)
    func showError()
}
