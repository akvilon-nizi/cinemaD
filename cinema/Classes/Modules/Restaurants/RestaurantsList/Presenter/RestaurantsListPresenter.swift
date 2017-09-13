//
// Created by Alexander Maslennikov on 25/07/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class RestaurantsListPresenter {

    weak var view: RestaurantsListViewInput!
    var interactor: RestaurantsListInteractorInput!
    var router: RestaurantsListRouterInput!
    weak var output: RestaurantsListModuleOutput!
}

// MARK: - RestaurantsListViewOutput

extension RestaurantsListPresenter: RestaurantsListViewOutput {

    func viewIsReady() {
        log.verbose("RestaurantsList is ready")
    }

    func pressMenuButton() {
        log.verbose("Menu button pressed")

        router.openMyOrder()
    }

    func pressMapButton() {
        log.verbose("Map button pressed")

        output?.needChangeContentFormat(new: .map)
    }

    func needRetryFetchRestaurants() {
        log.verbose("Need retry fetch restaurants")

        output?.needReloadRestaurants()
        view.showEmptyLoading()
    }
}

// MARK: - RestaurantsListInteractorOutput

extension RestaurantsListPresenter: RestaurantsListInteractorOutput {

}

// MARK: - RestaurantsListModuleInput

extension RestaurantsListPresenter: RestaurantsListModuleInput {

    // MARK: - RestaurantsSubmoduleInput

    func startFetchRestaurants() {
        log.verbose("Start fetch restaurants")

        view.showEmptyLoading()
    }

    func update(displayItems: [RestaurantsDisplayItem]) {
        log.verbose("Update all restaurants in list")

        view.update(displayItems: displayItems)
    }

    func finishFetchRestaurants(with error: String) {
        log.error("Finish fetch restaurants with error: \(error)")

        view.show(error: error)
    }
}
