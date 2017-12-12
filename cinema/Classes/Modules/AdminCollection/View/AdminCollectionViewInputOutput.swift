//
// Created by Danila Lyahomskiy on 11/12/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol AdminCollectionViewInput: class {

    func setupInitialState()
}

protocol AdminCollectionViewOutput {

    func viewIsReady()
    
    func backTap()

    func homeTap()
}
