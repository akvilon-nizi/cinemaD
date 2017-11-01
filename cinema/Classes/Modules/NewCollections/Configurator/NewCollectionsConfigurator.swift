//
// Created by akvilon-nizi on 31/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class NewCollectionsConfigurator {

    static let tag: String = "NewCollectionsTag"

    var appRouter: AppRouterProtocol!

    var provider: RxMoyaProvider<FoodleTarget>!

    let id: String

    let nameCol: String

    let watched: [Film]

    init(id: String, nameCol: String, watched: [Film]) {
        self.id = id
        self.nameCol = nameCol
        self.watched = watched
    }

    func configureModule() -> UIViewController {
        let router = NewCollectionsRouter()
        router.appRouter = appRouter

        let presenter = NewCollectionsPresenter()
        presenter.router = router

        let interactor = NewCollectionsInteractor()
        interactor.output = presenter

        let viewController = NewCollectionsViewController()
        viewController.output = presenter
        viewController.nameCollections = nameCol
        viewController.watched = watched

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
