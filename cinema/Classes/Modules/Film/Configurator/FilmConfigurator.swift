//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class FilmConfigurator {

    static let tag: String = "FilmTag"

    var provider: RxMoyaProvider<FoodleTarget>!

    var appRouter: AppRouterProtocol!

    func configureModule() -> UIViewController {
        let router = FilmRouter()
        router.appRouter = appRouter

        let presenter = FilmPresenter()
        presenter.router = router

        let interactor = FilmInteractor()
        interactor.output = presenter

        let viewController = FilmViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
