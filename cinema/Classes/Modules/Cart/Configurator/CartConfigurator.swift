//
// Created by incetro on 17/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class CartConfigurator {

    static let tag: String = "CartTag"

    var appRouter: AppRouterProtocol!
    var provider: RxMoyaProvider<FoodleTarget>!

    func configureModule() -> UIViewController {
        let router = CartRouter()
        router.appRouter = appRouter

        let presenter = CartPresenter()
        presenter.router = router

        let interactor = CartInteractor()
        interactor.output = presenter
        interactor.provider = provider

        let viewController = CartViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
