//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class ActorsConfigurator {

    static let tag: String = "ActorsTag"

    var appRouter: AppRouterProtocol!

    var provider: RxMoyaProvider<FoodleTarget>!

    let id: String

    let name: String

    let role: String

    let persons: [PersonFromFilm]

    init(id: String, name: String, role: String, persons: [PersonFromFilm]) {
        self.id = id
        self.name = name
        self.role = role
        self.persons = persons
    }

    func configureModule() -> UIViewController {
        let router = ActorsRouter()
        router.appRouter = appRouter

        let presenter = ActorsPresenter()
        presenter.router = router
        presenter.id = id

        let interactor = ActorsInteractor()
        interactor.output = presenter
        interactor.provider = provider

        let viewController = ActorsViewController(name: name, role: role, persons: persons)
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
