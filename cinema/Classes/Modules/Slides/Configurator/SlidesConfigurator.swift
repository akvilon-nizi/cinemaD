//
// Created by DanilaLyahomskiy on 30/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class SlidesConfigurator {

    static let tag: String = "SlidesTag"

    var firstLaunchManager: FirstLaunchManagerProtocol!
    var appRouter: AppRouterProtocol!
    var authTokenManager: AuthTokenManagerProtocol!

    func configureModule() -> UIViewController {

        authTokenManager.removeApiToken()

        let router = SlidesRouter()
        router.appRouter = appRouter

        let presenter = SlidesPresenter()
        presenter.router = router

        let interactor = SlidesInteractor()
        interactor.output = presenter
        interactor.firstLaunchManager = firstLaunchManager

        let viewController = SlidesViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
