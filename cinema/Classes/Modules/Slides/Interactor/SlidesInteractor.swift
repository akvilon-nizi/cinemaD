//
// Created by DanilaLyahomskiy on 30/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class SlidesInteractor {

    weak var output: SlidesInteractorOutput!

    var firstLaunchManager: FirstLaunchManagerProtocol!
}

// MARK: - SlidesInteractorInput

extension SlidesInteractor: SlidesInteractorInput {

    func slidesClosed() {
        firstLaunchManager.isNotFirstLaunch = true
    }

}
