//
// Created by akvilon-nizi on 31/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class NewCollectionsPresenter {

    weak var view: NewCollectionsViewInput!
    var interactor: NewCollectionsInteractorInput!
    var router: NewCollectionsRouterInput!
    weak var output: NewCollectionsModuleOutput?
}

// MARK: - NewCollectionsViewOutput

extension NewCollectionsPresenter: NewCollectionsViewOutput {

    func viewIsReady() {
        log.verbose("NewCollections is ready")
    }

    func backButtonTap() {
        router.close()
    }
}

// MARK: - NewCollectionsInteractorOutput

extension NewCollectionsPresenter: NewCollectionsInteractorOutput {

}
