//
// Created by Danila Lyahomskiy on 28/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol ReviewsViewInput: class {

    func setupInitialState()
}

protocol ReviewsViewOutput {

    func viewIsReady()
}
