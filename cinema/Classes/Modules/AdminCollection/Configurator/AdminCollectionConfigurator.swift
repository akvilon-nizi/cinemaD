//
// Created by Danila Lyahomskiy on 11/12/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class AdminCollectionConfigurator {

    static let tag: String = "AdminCollectionTag"

    var appRouter: AppRouterProtocol!

    var provider: RxMoyaProvider<FoodleTarget>!

    let name: String

    let id: String

    init(id: String, name: String) {
        self.id = id
        self.name = name
    }

    func configureModule() -> UIViewController {
        let router = AdminCollectionRouter()
        router.appRouter = appRouter

        let presenter = AdminCollectionPresenter()
        presenter.router = router
        presenter.id = id

        let interactor = AdminCollectionInteractor()
        interactor.output = presenter
        interactor.provider = provider

        let viewController = AdminCollectionViewController(name: name)
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
