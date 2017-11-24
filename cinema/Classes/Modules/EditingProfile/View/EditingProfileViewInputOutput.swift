//
// Created by akvilon-nizi on 24/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol EditingProfileViewInput: class {

    func setupInitialState()
}

protocol EditingProfileViewOutput {

    func viewIsReady()
}
