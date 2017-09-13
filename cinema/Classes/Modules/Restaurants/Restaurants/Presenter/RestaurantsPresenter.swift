//
// Created by Alexander Maslennikov on 21/07/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import CoreLocation

enum RestaurantsContentFormat: Int {
    case map
    case list
}

class RestaurantsPresenter {

    weak var view: RestaurantsViewInput!
    var interactor: RestaurantsInteractorInput!
    var router: RestaurantsRouterInput!
    weak var output: RestaurantsModuleOutput?

    var mapInput: RestaurantsMapModuleInput?
    var listInput: RestaurantsListModuleInput?

    var dataCollector: RestaurantsDataCollector!

    var contentFormat: RestaurantsContentFormat

    init(contentFormat: RestaurantsContentFormat) {
        self.contentFormat = contentFormat
    }
}

// MARK: - RestaurantsViewOutput

extension RestaurantsPresenter: RestaurantsViewOutput {

    func viewIsReady() {
        log.verbose("Restaurants is ready with content format: \(contentFormat)")

        view.changeContentFormat(new: contentFormat)

        interactor.startFetchingUserLocation()
        interactor.fetchRestaurants()

        mapInput?.startFetchRestaurants()
        listInput?.startFetchRestaurants()
    }
}

// MARK: - RestaurantsInteractorOutput

extension RestaurantsPresenter: RestaurantsInteractorOutput {

    func successFetch(restaurants: [Restaurant]) {
        log.verbose("Success fetch restaurants count: \(restaurants.count)")
        dataCollector.update(restaurants: restaurants)

        mapInput?.update(displayItems: dataCollector.displayItems)
        listInput?.update(displayItems: dataCollector.displayItems)
    }

    func finishFetchRestaurants(errorMessage: String) {
        log.error("Finish fetch restaurants with error: \(errorMessage)")

        mapInput?.finishFetchRestaurants(with: errorMessage)
        listInput?.finishFetchRestaurants(with: errorMessage)
    }

    func needUpdate(coordinate: CLLocationCoordinate2D?) {
        log.verbose("Need update coordinate")

        mapInput?.update(userCoordinate: coordinate)
    }
}

// MARK: - RestaurantsItemOutput

extension RestaurantsPresenter: RestaurantsItemOutput {

    func needOpenRestaurant(with id: Int) {
        log.verbose("Need open restaurant with id: \(id)")

        router.preformTransitionToRestaurantModule(with: id)
    }

    func needCheckTableInRestaurant(with id: Int) {
        log.warning("Need check table in restaurant with id: \(id)")
    }
}

// MARK: - RestaurantsMapModuleOutput, RestaurantsListModuleOutput

extension RestaurantsPresenter: RestaurantsMapModuleOutput, RestaurantsListModuleOutput {

    // MARK: - RestaurantsSubmoduleOutput

    func needChangeContentFormat(new: RestaurantsContentFormat) {
        log.verbose("Need change content format - new: \(new)")

        guard new != contentFormat else {
            log.verbose("Change format locked")
            return
        }

        view.changeContentFormat(new: new)

        contentFormat = new
    }

    func needReloadRestaurants() {
        log.verbose("Need reload restaurants")

        interactor.fetchRestaurants()
    }
}
