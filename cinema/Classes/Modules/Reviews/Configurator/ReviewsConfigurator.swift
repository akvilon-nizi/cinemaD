//
// Created by Danila Lyahomskiy on 28/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class ReviewsConfigurator {

    static let tag: String = "ReviewsTag"

    var appRouter: AppRouterProtocol!

    func configureModule() -> UIViewController {
        let router = ReviewsRouter()
        router.appRouter = appRouter

        let presenter = ReviewsPresenter()
        presenter.router = router

        let interactor = ReviewsInteractor()
        interactor.output = presenter

        let viewController = ReviewsViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
