//
// Created by akvilon-nizi on 24/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class EditingProfileConfigurator {

    var provider: RxMoyaProvider<FoodleTarget>!

    static let tag: String = "EditingProfileTag"

    var appRouter: AppRouterProtocol!

    func configureModule() -> UIViewController {
        let router = EditingProfileRouter()
        router.appRouter = appRouter

        let presenter = EditingProfilePresenter()
        presenter.router = router

        let interactor = EditingProfileInteractor()
        interactor.output = presenter

        let viewController = EditingProfileViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
