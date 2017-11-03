//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class ActorsConfigurator {

    static let tag: String = "ActorsTag"

    var appRouter: AppRouterProtocol!

    var provider: RxMoyaProvider<FoodleTarget>!

    func configureModule() -> UIViewController {
        let router = ActorsRouter()
        router.appRouter = appRouter

        let presenter = ActorsPresenter()
        presenter.router = router

        let interactor = ActorsInteractor()
        interactor.output = presenter

        let viewController = ActorsViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
