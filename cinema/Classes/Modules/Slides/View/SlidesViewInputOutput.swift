//
// Created by DanilaLyahomskiy on 30/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol SlidesViewInput: class {

    func setupInitialState()
}

protocol SlidesViewOutput {

    func viewIsReady()

    func nextActions()

    func getSlidesArrayInfo() -> [SlideStruct]
}
