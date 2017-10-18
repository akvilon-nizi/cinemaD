//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class PhoneConfigurator {

    static let tag: String = "PhoneTag"

    var provider: RxMoyaProvider<FoodleTarget>!

    var appRouter: AppRouterProtocol!

    let phone: String

    let uid: String

    init(uid: String, phone: String) {
        self.uid = uid
        self.phone = phone
    }

    func configureModule() -> UIViewController {
        let router = PhoneRouter()
        router.appRouter = appRouter

        let presenter = PhonePresenter()
        presenter.router = router

        let interactor = PhoneInteractor()
        interactor.output = presenter
        interactor.provider = provider

        let viewController = PhoneViewController()
        viewController.output = presenter
        viewController.phone = phone
        viewController.uid = uid

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
