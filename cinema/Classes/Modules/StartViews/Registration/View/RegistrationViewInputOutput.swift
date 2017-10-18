//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol RegistrationViewInput: class {

    func setupInitialState()

    func showNetworkError()
}

protocol RegistrationViewOutput {

    func viewIsReady()

    func backTap()

    func nextButtonTap(password: String, name: String, phone: String, phoneIn: String)
}
