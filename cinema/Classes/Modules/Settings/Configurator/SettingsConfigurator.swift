//
// Created by akvilon-nizi on 23/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class SettingsConfigurator {

    static let tag: String = "SettingsTag"

    var appRouter: AppRouterProtocol!

    var locationManager: LocationManagerProtocol!

    var provider: RxMoyaProvider<FoodleTarget>!

    var authTokenManager: AuthTokenManagerProtocol!

    func configureModule() -> UIViewController {
        let router = SettingsRouter()
        router.appRouter = appRouter

        let presenter = SettingsPresenter()
        presenter.router = router
        presenter.locationManager = locationManager
        presenter.authTokenManager = authTokenManager

        let interactor = SettingsInteractor()
        interactor.output = presenter
        interactor.provider = provider

        let viewController = SettingsViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
