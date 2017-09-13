//
// Created by incetro on 21/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class AuthCodeConfigurator {

    static let tag: String = "AuthCodeTag"

    let phone: String
    let needToDismiss: Bool
    var appRouter: AppRouterProtocol!
    var provider: RxMoyaProvider<FoodleTarget>!
    var authTokenManager: AuthTokenManagerProtocol!
    var regionManager: RegionManager!

    init(phone: String, needToDismiss: Bool) {

        self.phone = phone
        self.needToDismiss = needToDismiss
    }

    func configureModule() -> UIViewController {
        let router = AuthCodeRouter()
        router.appRouter = appRouter

        let presenter = AuthCodePresenter(phone: phone, needToDismiss: needToDismiss)
        presenter.router = router

        let interactor = AuthCodeInteractor()
        interactor.output = presenter
        interactor.provider = provider
        interactor.authTokenManager = authTokenManager
        interactor.regionManager = regionManager

        let viewController = AuthCodeViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
