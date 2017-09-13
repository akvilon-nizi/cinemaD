//
// Created by DanilaLyahomskiy on 01/09/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class CardOfProductConfigurator {

    static let tag: String = "CardOfProductTag"

    var appRouter: AppRouterProtocol!
    var provider: RxMoyaProvider<FoodleTarget>!

    let productID: Int

    init(productID: Int) {
        self.productID = productID
    }

    func configureModule() -> UIViewController {
        let router = CardOfProductRouter()
        router.appRouter = appRouter

        let presenter = CardOfProductPresenter(id: productID)
        presenter.router = router

        let interactor = CardOfProductInteractor()
        interactor.output = presenter
        interactor.provider = provider

        let viewController = CardOfProductViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
