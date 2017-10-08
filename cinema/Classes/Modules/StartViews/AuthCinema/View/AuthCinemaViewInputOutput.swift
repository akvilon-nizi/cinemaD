//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol AuthCinemaViewInput: class {

    func setupInitialState()
}

protocol AuthCinemaViewOutput {

    func viewIsReady()

    func backTap()

    func helpAuth()

    func auth()
}
