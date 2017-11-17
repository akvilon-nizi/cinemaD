//
// Created by akvilon-nizi on 16/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class NewsConfigurator {

    static let tag: String = "NewsTag"

    var appRouter: AppRouterProtocol!

    func configureModule() -> UIViewController {
        let router = NewsRouter()
        router.appRouter = appRouter

        let presenter = NewsPresenter()
        presenter.router = router

        let interactor = NewsInteractor()
        interactor.output = presenter

        let viewController = NewsViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
