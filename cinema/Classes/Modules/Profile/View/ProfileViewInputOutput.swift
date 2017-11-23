//
// Created by akvilon-nizi on 23/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol ProfileViewInput: class {

    func setupInitialState()
}

protocol ProfileViewOutput {

    func viewIsReady()
}
