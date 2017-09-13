//
// Created by Alexander Maslennikov on 24/07/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class RestaurantPresenter {

    weak var view: RestaurantViewInput!
    var interactor: RestaurantInteractorInput!
    var router: RestaurantRouterInput!
    weak var output: RestaurantModuleOutput?

    let restaurantId: Int

    var restaurant: FullRestaurant?

    init(id: Int) {
        restaurantId = id
    }
}

// MARK: - RestaurantViewOutput

extension RestaurantPresenter: RestaurantViewOutput {

    func viewIsReady() {

        log.verbose("Restaurant-\(restaurantId) is ready")
        interactor.obtainRestaurant(byRestaurantID: restaurantId)
    }

    func openMenuButtonTapped(selectedCategoryID: Int) {

        guard let restaurant = restaurant else {

            return
        }

        router.openMenu(selectedCategoryID: selectedCategoryID, restaurant: restaurant)
    }
}

// MARK: - RestaurantInteractorOutput

extension RestaurantPresenter: RestaurantInteractorOutput {

    func obtainRestaurantFailure(errorMessage: String) {

        log.error("Finish fetch restaurant with error: \(errorMessage)")
        router.performTransitionToNetworkAlert(message: errorMessage)
    }

    func obtainRestaurantSuccess(restaurant: FullRestaurant) {

        self.restaurant = restaurant
        view.setupInitialState(withRestaurant: restaurant)
    }
}
