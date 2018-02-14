//
// Created by Danila Lyahomskiy on 05/12/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class FriendsConfigurator {

    static let tag: String = "FriendsTag"

    var appRouter: AppRouterProtocol!

    var provider: RxMoyaProvider<FoodleTarget>!

    func configureModule() -> UIViewController {
        let router = FriendsRouter()
        router.appRouter = appRouter

        let presenter = FriendsPresenter()
        presenter.router = router

        let interactor = FriendsInteractor()
        interactor.output = presenter
        interactor.provider = provider

        let viewController = FriendsViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
