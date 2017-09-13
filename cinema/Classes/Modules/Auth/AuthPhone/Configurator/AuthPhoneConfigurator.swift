//
// Created by Alexander Maslennikov on 04/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class AuthPhoneConfigurator {

    static let tag: String = "AuthPhoneTag"

    var appRouter: AppRouterProtocol!
    var provider: RxMoyaProvider<FoodleTarget>!

    func configureModule() -> UIViewController {
        let router = AuthPhoneRouter()
        router.appRouter = appRouter

        let presenter = AuthPhonePresenter()
        presenter.router = router

        let interactor = AuthPhoneInteractor()
        interactor.provider = provider
        interactor.output = presenter

        let viewController = AuthPhoneViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
