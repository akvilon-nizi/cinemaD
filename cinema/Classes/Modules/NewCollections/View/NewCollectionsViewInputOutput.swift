//
// Created by akvilon-nizi on 31/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol NewCollectionsViewInput: class {

    func setupInitialState()
}

protocol NewCollectionsViewOutput {

    func viewIsReady()

    func backButtonTap()
}
