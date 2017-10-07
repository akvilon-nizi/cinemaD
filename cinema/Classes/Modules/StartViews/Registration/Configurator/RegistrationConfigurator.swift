//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class RegistrationConfigurator {

    static let tag: String = "RegistrationTag"

    var provider: RxMoyaProvider<FoodleTarget>!

    var appRouter: AppRouterProtocol!

    func configureModule() -> UIViewController {
        let router = RegistrationRouter()
        router.appRouter = appRouter

        let presenter = RegistrationPresenter()
        presenter.router = router

        let interactor = RegistrationInteractor()
        interactor.output = presenter

        let viewController = RegistrationViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
