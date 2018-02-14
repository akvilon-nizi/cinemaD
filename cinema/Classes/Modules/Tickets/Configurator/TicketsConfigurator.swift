//
// Created by Danila Lyahomskiy on 25/12/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class TicketsConfigurator {

    static let tag: String = "TicketsTag"

    var appRouter: AppRouterProtocol!

    var provider: RxMoyaProvider<FoodleTarget>!

    func configureModule() -> UIViewController {
        let router = TicketsRouter()
        router.appRouter = appRouter

        let presenter = TicketsPresenter()
        presenter.router = router

        let interactor = TicketsInteractor()
        interactor.output = presenter

        let viewController = TicketsViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
