//
// Created by incetro on 25/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class TermsConfigurator {

    static let tag: String = "TermsTag"

    var appRouter: AppRouterProtocol!
    var provider: RxMoyaProvider<FoodleTarget>!
    var termsManager: TermsManager!

    func configureModule() -> UIViewController {
        let router = TermsRouter()
        router.appRouter = appRouter

        let presenter = TermsPresenter()
        presenter.router = router

        let interactor = TermsInteractor()
        interactor.output = presenter
        interactor.provider = provider
        interactor.termsManager = termsManager

        let viewController = TermsViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
