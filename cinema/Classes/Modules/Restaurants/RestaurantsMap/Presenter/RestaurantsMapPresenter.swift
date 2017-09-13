//
// Created by Alexander Maslennikov on 25/07/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import CoreLocation

class RestaurantsMapPresenter {

    weak var view: RestaurantsMapViewInput!
    var interactor: RestaurantsMapInteractorInput!
    var router: RestaurantsMapRouterInput!
    weak var output: RestaurantsMapModuleOutput?
}

// MARK: - RestaurantsMapViewOutput

extension RestaurantsMapPresenter: RestaurantsMapViewOutput {

    func viewIsReady() {
        log.verbose("RestaurantsMap is ready")
    }

    func pressListButton() {
        log.verbose("List button pressed")

        output?.needChangeContentFormat(new: .list)
    }

    func pressMenuButton() {

        router.openLeftMenu()
    }
}

// MARK: - RestaurantsMapInteractorOutput

extension RestaurantsMapPresenter: RestaurantsMapInteractorOutput {

}

// MARK: - RestaurantsMapModuleInput

extension RestaurantsMapPresenter: RestaurantsMapModuleInput {

    func update(userCoordinate: CLLocationCoordinate2D?) {
        log.verbose("Update user coordinate")

        view.updateUserMarker(with: userCoordinate)
    }

    // MARK: - RestaurantsSubmoduleInput

    func startFetchRestaurants() {
        log.verbose("Start fetch restaurants")
    }

    func update(displayItems: [RestaurantsDisplayItem]) {
        log.verbose("Update all restaurants in map")

        view.show(displayItems: displayItems)
    }

    func finishFetchRestaurants(with error: String) {
        log.error("Finish fetch restaurants with error: \(error)")
    }
}
