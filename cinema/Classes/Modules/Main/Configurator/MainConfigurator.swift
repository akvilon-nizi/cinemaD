//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class MainConfigurator {

    static let tag: String = "MainTag"

    var provider: RxMoyaProvider<FoodleTarget>!

    var locationManager: LocationManagerProtocol!

    var appRouter: AppRouterProtocol!

    func configureModule() -> UIViewController {

        let router = MainRouter()
        router.appRouter = appRouter

        let presenter = MainPresenter()
        presenter.router = router
        presenter.locationManager = locationManager

        let interactor = MainInteractor()
        interactor.output = presenter
        interactor.provider = provider

        let viewController = MainViewController()
        viewController.output = presenter
        viewController.provider = provider

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
