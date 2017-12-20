//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class AuthCinemaConfigurator {

    static let tag: String = "AuthCinemaTag"

    var appRouter: AppRouterProtocol!

    var provider: RxMoyaProvider<FoodleTarget>!

    var authTokenManager: AuthTokenManagerProtocol!

    let isError: Bool

    init(isError: Bool = false) {
        self.isError = isError
    }

    func configureModule() -> UIViewController {
        let router = AuthCinemaRouter()
        router.appRouter = appRouter

        let presenter = AuthCinemaPresenter()
        presenter.router = router
        presenter.isError = isError

        let interactor = AuthCinemaInteractor()
        interactor.output = presenter
        interactor.provider = provider
        interactor.authTokenManager = authTokenManager

        let viewController = AuthCinemaViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
