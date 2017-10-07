//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class MainConfigurator {

    static let tag: String = "MainTag"

    var provider: RxMoyaProvider<FoodleTarget>!

    var appRouter: AppRouterProtocol!

    func configureModule() -> UIViewController {
        let router = MainRouter()
        router.appRouter = appRouter

        let presenter = MainPresenter()
        presenter.router = router

        let interactor = MainInteractor()
        interactor.output = presenter

        let viewController = MainViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
