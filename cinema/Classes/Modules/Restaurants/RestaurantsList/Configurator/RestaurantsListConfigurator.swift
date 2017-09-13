//
// Created by Alexander Maslennikov on 25/07/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class RestaurantsListConfigurator {

    static let tag: String = "RestaurantsListTag"

    var appRouter: AppRouterProtocol!
    weak var output: RestaurantsListModuleOutput!

    func configureModule() -> UIViewController {
        let router = RestaurantsListRouter()
        router.appRouter = appRouter

        let presenter = RestaurantsListPresenter()
        presenter.router = router
        presenter.output = output
        output.listInput = presenter

        let interactor = RestaurantsListInteractor()
        interactor.output = presenter

        let viewController = RestaurantsListViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
