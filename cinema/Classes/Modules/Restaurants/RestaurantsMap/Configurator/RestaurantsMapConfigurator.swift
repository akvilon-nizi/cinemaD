//
// Created by Alexander Maslennikov on 25/07/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class RestaurantsMapConfigurator {

    static let tag: String = "RestaurantsMapTag"

    var appRouter: AppRouterProtocol!
    weak var output: RestaurantsMapModuleOutput!

    func configureModule() -> UIViewController {
        let router = RestaurantsMapRouter()
        router.appRouter = appRouter

        let presenter = RestaurantsMapPresenter()
        presenter.router = router
        presenter.output = output
        output.mapInput = presenter

        let interactor = RestaurantsMapInteractor()
        interactor.output = presenter

        let viewController = RestaurantsMapViewController()
        //viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
