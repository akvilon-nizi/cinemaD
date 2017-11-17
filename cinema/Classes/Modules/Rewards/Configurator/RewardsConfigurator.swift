//
// Created by akvilon-nizi on 16/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class RewardsConfigurator {

    static let tag: String = "RewardsTag"

    var appRouter: AppRouterProtocol!

    func configureModule() -> UIViewController {
        let router = RewardsRouter()
        router.appRouter = appRouter

        let presenter = RewardsPresenter()
        presenter.router = router

        let interactor = RewardsInteractor()
        interactor.output = presenter

        let viewController = RewardsViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
