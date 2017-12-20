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

    let output: NewCollectionsModuleOutput

    init(output: NewCollectionsModuleOutput, id: String, nameCol: String, watched: [Film]) {
        self.id = id
        self.nameCol = nameCol
        self.watched = watched
        self.output = output
    }

    func configureModule() -> UIViewController {
        let router = NewCollectionsRouter()
        router.appRouter = appRouter

        let presenter = NewCollectionsPresenter()
        presenter.router = router
        presenter.id = id
        presenter.output = output

        let interactor = NewCollectionsInteractor()
        interactor.output = presenter
        interactor.provider = provider

        let viewController = NewCollectionsViewController()
        viewController.output = presenter
        viewController.nameCollections = nameCol
        for film in watched {
            let filmVC = Film(id: film.id, name: film.name, imageUrl: film.imageUrl, rate: film.rate!)
            viewController.watched.append(filmVC)
        }

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
