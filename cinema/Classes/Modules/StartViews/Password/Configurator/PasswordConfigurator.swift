//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class PasswordConfigurator {

    static let tag: String = "PasswordTag"

    var appRouter: AppRouterProtocol!

    func configureModule() -> UIViewController {
        let router = PasswordRouter()
        router.appRouter = appRouter

        let presenter = PasswordPresenter()
        presenter.router = router

        let interactor = PasswordInteractor()
        interactor.output = presenter

        let viewController = PasswordViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
