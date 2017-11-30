//
// Created by Danila Lyahomskiy on 28/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class ReviewsConfigurator {

    static let tag: String = "ReviewsTag"

    var provider: RxMoyaProvider<FoodleTarget>!

    var appRouter: AppRouterProtocol!

    let filmID: String

    let name: String

    let genres: String

    init(filmID: String, name: String, genres: String) {
        self.filmID = filmID
        self.name = name
        self.genres = genres
    }

    func configureModule() -> UIViewController {
        let router = ReviewsRouter()
        router.appRouter = appRouter

        let presenter = ReviewsPresenter()
        presenter.router = router
        presenter.filmID = filmID

        let interactor = ReviewsInteractor()
        interactor.output = presenter
        interactor.provider = provider

        let viewController = ReviewsViewController(filmID: filmID, name: name, genres: genres)
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
