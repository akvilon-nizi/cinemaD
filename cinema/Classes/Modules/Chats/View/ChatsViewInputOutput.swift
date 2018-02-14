//
// Created by Danila Lyahomskiy on 25/12/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol ChatsViewInput: class {

    func setupInitialState()
}

protocol ChatsViewOutput {

    func viewIsReady()

    func backButtonTap()
}
