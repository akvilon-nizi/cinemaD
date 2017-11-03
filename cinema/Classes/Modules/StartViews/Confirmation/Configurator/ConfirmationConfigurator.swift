//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class ConfirmationConfigurator {

    static let tag: String = "ConfirmationTag"

    var provider: RxMoyaProvider<FoodleTarget>!
    var authTokenManager: AuthTokenManagerProtocol!

    var appRouter: AppRouterProtocol!

    let uid: String

    let phone: String

    let isRestore: Bool

    init(uid: String, phone: String, isRestore: Bool) {
        self.uid = uid
        self.phone = phone
        self.isRestore = isRestore
    }

    func configureModule() -> UIViewController {
        let router = ConfirmationRouter()
        router.appRouter = appRouter

        let presenter = ConfirmationPresenter(uid: uid)
        presenter.router = router

        let interactor = ConfirmationInteractor()
        interactor.output = presenter
        interactor.provider = provider
        interactor.authTokenManager = authTokenManager
        interactor.isRestore = isRestore

        let viewController = ConfirmationViewController(phone)
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
