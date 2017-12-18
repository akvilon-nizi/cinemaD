//
// Created by akvilon-nizi on 23/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class SettingsConfigurator {

    static let tag: String = "SettingsTag"

    var appRouter: AppRouterProtocol!

    var locationManager: LocationManagerProtocol!

    func configureModule() -> UIViewController {
        let router = SettingsRouter()
        router.appRouter = appRouter

        let presenter = SettingsPresenter()
        presenter.router = router
        presenter.locationManager = locationManager

        let interactor = SettingsInteractor()
        interactor.output = presenter

        let viewController = SettingsViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
