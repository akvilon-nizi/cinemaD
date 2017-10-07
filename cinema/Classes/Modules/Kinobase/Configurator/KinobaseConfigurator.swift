//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class KinobaseConfigurator {

    static let tag: String = "KinobaseTag"

    var appRouter: AppRouterProtocol!

    var provider: RxMoyaProvider<FoodleTarget>!

    func configureModule() -> UIViewController {
        let router = KinobaseRouter()
        router.appRouter = appRouter

        let presenter = KinobasePresenter()
        presenter.router = router

        let interactor = KinobaseInteractor()
        interactor.output = presenter

        let viewController = KinobaseViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
