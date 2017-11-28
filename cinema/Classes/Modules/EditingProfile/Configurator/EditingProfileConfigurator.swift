//
// Created by akvilon-nizi on 24/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import RxMoya
import UIKit

class EditingProfileConfigurator {

    var provider: RxMoyaProvider<FoodleTarget>!

    static let tag: String = "EditingProfileTag"

    var appRouter: AppRouterProtocol!

    let nameUser: String

    let avatar: String

    let output: EditingProfileModuleOutput

    init(nameUser: String, avatar: String, output: EditingProfileModuleOutput) {
        self.nameUser = nameUser
        self.avatar = avatar
        self.output = output
    }

    func configureModule() -> UIViewController {
        let router = EditingProfileRouter()
        router.appRouter = appRouter

        let presenter = EditingProfilePresenter()
        presenter.router = router
        presenter.output = output

        let interactor = EditingProfileInteractor()
        interactor.output = presenter
        interactor.provider = provider

        let viewController = EditingProfileViewController(nameUser: nameUser, avatar: avatar)
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
