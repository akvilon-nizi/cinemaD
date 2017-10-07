//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class ConfirmationConfigurator {

    static let tag: String = "ConfirmationTag"

    var provider: RxMoyaProvider<FoodleTarget>!

    var appRouter: AppRouterProtocol!

    func configureModule() -> UIViewController {
        let router = ConfirmationRouter()
        router.appRouter = appRouter

        let presenter = ConfirmationPresenter()
        presenter.router = router

        let interactor = ConfirmationInteractor()
        interactor.output = presenter

        let viewController = ConfirmationViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
