//
// Created by akvilon-nizi on 16/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol RewardsViewInput: class {

    func setupInitialState()
}

protocol RewardsViewOutput {

    func viewIsReady()

    func backButtonTap()
}
