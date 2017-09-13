//
// Created by incetro on 21/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol AuthCodeViewInput: class {

    func setupInitialState(withPhone phone: String)
}

protocol AuthCodeViewOutput {

    func viewIsReady()

    func didEndEditing(code: String)

    func retryButtonTapped()

    func closeButtonTapped()
}
