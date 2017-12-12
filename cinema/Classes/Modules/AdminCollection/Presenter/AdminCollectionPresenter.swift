//
// Created by Danila Lyahomskiy on 11/12/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class AdminCollectionPresenter {

    weak var view: AdminCollectionViewInput!
    var interactor: AdminCollectionInteractorInput!
    var router: AdminCollectionRouterInput!
    weak var output: AdminCollectionModuleOutput?
}

// MARK: - AdminCollectionViewOutput

extension AdminCollectionPresenter: AdminCollectionViewOutput {

    func viewIsReady() {
        log.verbose("AdminCollection is ready")
    }

    func backTap() {
        router.close()
    }

    func homeTap() {
        router.home()
    }
}

// MARK: - AdminCollectionInteractorOutput

extension AdminCollectionPresenter: AdminCollectionInteractorOutput {

}
