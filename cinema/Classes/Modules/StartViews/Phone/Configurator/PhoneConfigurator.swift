//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class PhoneConfigurator {

    static let tag: String = "PhoneTag"

    var provider: RxMoyaProvider<FoodleTarget>!

    var appRouter: AppRouterProtocol!

    func configureModule() -> UIViewController {
        let router = PhoneRouter()
        router.appRouter = appRouter

        let presenter = PhonePresenter()
        presenter.router = router

        let interactor = PhoneInteractor()
        interactor.output = presenter

        let viewController = PhoneViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
