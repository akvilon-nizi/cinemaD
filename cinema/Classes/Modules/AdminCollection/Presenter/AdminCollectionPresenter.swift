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
    var id: String!
}

// MARK: - AdminCollectionViewOutput

extension AdminCollectionPresenter: AdminCollectionViewOutput {
    func openFilmID(_ filmId: String, name: String) {
        router.openFilm(videoId: filmId, name: name)
    }

    func viewIsReady() {
        log.verbose("AdminCollection is ready")
        interactor.getAdminCollections(id: id)
    }

    func backTap() {
        router.close()
    }

    func homeTap() {
        router.home()
    }

    func tokenError() {
        router.openStart()
    }
}

// MARK: - AdminCollectionInteractorOutput

extension AdminCollectionPresenter: AdminCollectionInteractorOutput {
    func getCollection(_ collection: Collection) {
        view.openCollection(collection)
    }

    func getError() {
        view.showNetworkError()
    }
}
