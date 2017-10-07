//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol MainViewInput: class {

    func setupInitialState()
}

protocol MainViewOutput {

    func viewIsReady()
}
