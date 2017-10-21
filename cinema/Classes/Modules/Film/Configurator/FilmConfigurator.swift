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

    let videoID: String
    let name: String

    init(videoID: String, name: String) {
        self.videoID = videoID
        self.name = name
    }

    func configureModule() -> UIViewController {
        let router = FilmRouter()
        router.appRouter = appRouter

        let presenter = FilmPresenter(videoID: videoID)
        presenter.router = router

        let interactor = FilmInteractor()
        interactor.output = presenter
        interactor.provider = provider

        let viewController = FilmViewController()
        viewController.output = presenter
        viewController.name = name

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
