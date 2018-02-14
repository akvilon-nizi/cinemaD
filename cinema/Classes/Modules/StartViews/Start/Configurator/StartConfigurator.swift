//
// Created by akvilon-nizi on 04/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class StartConfigurator {

    static let tag: String = "StartTag"

    var appRouter: AppRouterProtocol!

    var provider: RxMoyaProvider<FoodleTarget>!

    var authTokenManager: AuthTokenManagerProtocol!

    let isError: Bool 

    init(isError: Bool) {
        self.isError = isError
    }

    func configureModule() -> UIViewController {

        authTokenManager.removeApiToken()

        let router = StartRouter()
        router.appRouter = appRouter

        let presenter = StartPresenter(isError: isError)
        presenter.router = router

        let interactor = StartInteractor()
        interactor.output = presenter
        interactor.provider = provider
        interactor.authTokenManager = authTokenManager

        let viewController = StartViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
