//
// Created by incetro on 12/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class RestaurantMenuConfigurator {

    static let tag: String = "RestaurantMenuTag"

    var appRouter: AppRouterProtocol!
    var provider: RxMoyaProvider<FoodleTarget>!
    var moduleCreator: AppRouterModuleCreator!

    let selectedCategoryID: Int
    let restaurant: FullRestaurant

    init(selectedCategoryID: Int, restaurant: FullRestaurant) {
        self.selectedCategoryID = selectedCategoryID
        self.restaurant = restaurant
    }

    func configureModule() -> UIViewController {
        let router = RestaurantMenuRouter()
        router.appRouter = appRouter

        let factory = CategoryMenuModuleFactory(moduleCreator: moduleCreator)

        let presenter = RestaurantMenuPresenter(selectedCategoryID: selectedCategoryID, restaurant: restaurant, factory: factory)
        presenter.router = router

        let interactor = RestaurantMenuInteractor()
        interactor.output = presenter
        interactor.provider = provider

        let viewController = RestaurantMenuViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
