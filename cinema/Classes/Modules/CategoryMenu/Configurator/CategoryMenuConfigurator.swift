//
// Created by incetro on 22/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class CategoryMenuConfigurator {

    static let tag: String = "CategoryMenuTag"

    var appRouter: AppRouterProtocol!
    var provider: RxMoyaProvider<FoodleTarget>!

    let categoryID: Int
    let restaurant: FullRestaurant

    init(categoryID: Int, restaurant: FullRestaurant) {

        self.categoryID = categoryID
        self.restaurant = restaurant
    }

    func configureModule() -> UIViewController {
        let router = CategoryMenuRouter()
        router.appRouter = appRouter

        let presenter = CategoryMenuPresenter(categoryID: categoryID, restaurant: restaurant)
        presenter.router = router

        let interactor = CategoryMenuInteractor()
        interactor.output = presenter
        interactor.provider = provider

        let viewController = CategoryMenuViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
