//
// Created by akvilon-nizi on 04/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol StartViewInput: class {

    func setupInitialState()
    func showNetworkError(message: String)
    func getError()
}

protocol StartViewOutput {

    func viewIsReady()

    func authFromFb(_ authToken: String)

    func authFromVk(_ authToken: String)

    func getAuthCode(_ authCode: String)
}
