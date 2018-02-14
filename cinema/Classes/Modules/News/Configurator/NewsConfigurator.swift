//
// Created by akvilon-nizi on 16/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class NewsConfigurator {

    static let tag: String = "NewsTag"

    var provider: RxMoyaProvider<FoodleTarget>!

    var appRouter: AppRouterProtocol!

    let newsID: String

    init(newsID: String) {
        self.newsID = newsID
    }

    func configureModule() -> UIViewController {
        let router = NewsRouter()
        router.appRouter = appRouter

        let presenter = NewsPresenter()
        presenter.router = router
        presenter.newsID = newsID

        let interactor = NewsInteractor()
        interactor.output = presenter
        interactor.provider = provider

        let viewController = NewsViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
