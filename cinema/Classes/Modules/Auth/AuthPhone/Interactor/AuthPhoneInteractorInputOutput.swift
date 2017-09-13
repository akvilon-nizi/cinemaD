//
// Created by Alexander Maslennikov on 04/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol AuthPhoneInteractorInput {

    func sendSMSCode(phone: String)
}

protocol AuthPhoneInteractorOutput: class {

    func finishSendSMSCode(phone: String, errorMessage: String?)
}
