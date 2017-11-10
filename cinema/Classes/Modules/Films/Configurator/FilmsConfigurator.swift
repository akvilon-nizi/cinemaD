//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class FilmsConfigurator {

    static let tag: String = "FilmsTag"

    var provider: RxMoyaProvider<FoodleTarget>!

    var appRouter: AppRouterProtocol!

    var films: [Film]!

    func configureModule() -> UIViewController {
        let router = FilmsRouter()
        router.appRouter = appRouter

        let presenter = FilmsPresenter()
        presenter.router = router
        presenter.films = films

        let interactor = FilmsInteractor()
        interactor.output = presenter
        interactor.provider = provider

        let viewController = FilmsViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
