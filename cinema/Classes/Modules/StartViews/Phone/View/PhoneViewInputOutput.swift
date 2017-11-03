//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol PhoneViewInput: class {

    func setupInitialState()

    func showNetworkError()
}

protocol PhoneViewOutput {

    func viewIsReady()

    func backTap()

    func next(phone: String, uid: String?, phoneCorrect: String?)

}
