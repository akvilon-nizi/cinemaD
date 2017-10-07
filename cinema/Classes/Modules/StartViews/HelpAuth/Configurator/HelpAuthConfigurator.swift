//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class HelpAuthConfigurator {

    static let tag: String = "HelpAuthTag"

    var provider: RxMoyaProvider<FoodleTarget>!

    var appRouter: AppRouterProtocol!

    func configureModule() -> UIViewController {
        let router = HelpAuthRouter()
        router.appRouter = appRouter

        let presenter = HelpAuthPresenter()
        presenter.router = router

        let interactor = HelpAuthInteractor()
        interactor.output = presenter

        let viewController = HelpAuthViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
