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
        interactor.provider = provider

        let controller1 = UIViewController()
        controller1.view.backgroundColor = .red
        let controller2 = UIViewController()
        controller2.view.backgroundColor = .blue
        let controllers: [UIViewController] = [controller1, controller2]
        let viewController = KinobaseViewController(controllers: controllers)
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
