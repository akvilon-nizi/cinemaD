//
// Created by DanilaLyahomskiy on 05/09/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class MyOrderConfigurator {

    static let tag: String = "MyOrderTag"

    var provider: RxMoyaProvider<FoodleTarget>!

    var appRouter: AppRouterProtocol!

    func configureModule() -> UIViewController {
        let router = MyOrderRouter()
        router.appRouter = appRouter

        let presenter = MyOrderPresenter()
        presenter.router = router
        presenter.dataCollector = OrdersDataCollector(itemOutput: presenter)

        let interactor = MyOrderInteractor()
        interactor.output = presenter
        interactor.provider = provider

        let viewController = MyOrderViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
