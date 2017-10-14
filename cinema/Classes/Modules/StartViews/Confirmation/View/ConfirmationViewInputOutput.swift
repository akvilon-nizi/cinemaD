//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol ConfirmationViewInput: class {

    func setupInitialState()

    func showNetworkError()
}

protocol ConfirmationViewOutput {

    func viewIsReady()

    func back()

    func repeatCode()

    func next()

    func auth()

    func sendCode(code: String)
}
