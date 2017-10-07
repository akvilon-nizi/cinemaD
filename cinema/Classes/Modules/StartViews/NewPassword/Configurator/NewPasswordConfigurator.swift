//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class NewPasswordConfigurator {

    static let tag: String = "NewPasswordTag"

    var provider: RxMoyaProvider<FoodleTarget>!

    var appRouter: AppRouterProtocol!

    func configureModule() -> UIViewController {
        let router = NewPasswordRouter()
        router.appRouter = appRouter

        let presenter = NewPasswordPresenter()
        presenter.router = router

        let interactor = NewPasswordInteractor()
        interactor.output = presenter

        let viewController = NewPasswordViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
