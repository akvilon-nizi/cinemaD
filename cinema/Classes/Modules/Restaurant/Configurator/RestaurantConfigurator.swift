//
// Created by Alexander Maslennikov on 24/07/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class RestaurantConfigurator {

    static let tag: String = "RestaurantTag"

    var appRouter: AppRouterProtocol!
    var provider: RxMoyaProvider<FoodleTarget>!

    let id: Int

    init(id: Int) {
        self.id = id
    }

    func configureModule() -> UIViewController {
        let router = RestaurantRouter()
        router.appRouter = appRouter

        let presenter = RestaurantPresenter(id: id)
        presenter.router = router

        let interactor = RestaurantInteractor()
        interactor.output = presenter
        interactor.provider = provider

        let viewController = RestaurantViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
