//
// Created by akvilon-nizi on 23/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class ProfileConfigurator {

    static let tag: String = "ProfileTag"

    var appRouter: AppRouterProtocol!

    var provider: RxMoyaProvider<FoodleTarget>!

    let mainView: MainTabView

    init(_ mainView: MainTabView) {
        self.mainView = mainView
    }

    func configureModule() -> UIViewController {
        let router = ProfileRouter(mainView)
        router.appRouter = appRouter

        let presenter = ProfilePresenter()
        presenter.router = router

        let interactor = ProfileInteractor()
        interactor.output = presenter
        interactor.provider = provider

        let viewController = ProfileViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
