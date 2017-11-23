//
// Created by akvilon-nizi on 23/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class ProfileConfigurator {

    static let tag: String = "ProfileTag"

    var appRouter: AppRouterProtocol!

    func configureModule() -> UIViewController {
        let router = ProfileRouter()
        router.appRouter = appRouter

        let presenter = ProfilePresenter()
        presenter.router = router

        let interactor = ProfileInteractor()
        interactor.output = presenter

        let viewController = ProfileViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
