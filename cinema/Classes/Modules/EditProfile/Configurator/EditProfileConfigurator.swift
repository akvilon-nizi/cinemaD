//
// Created by incetro on 26/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class EditProfileConfigurator {

    static let tag: String = "EditProfileTag"

    var appRouter: AppRouterProtocol!
    var provider: RxMoyaProvider<FoodleTarget>!

    let profile: Profile
    let output: EditProfileModuleOutput

    init(profile: Profile, output: EditProfileModuleOutput) {

        self.profile = profile
        self.output = output
    }

    func configureModule() -> UIViewController {
        let router = EditProfileRouter()
        router.appRouter = appRouter

        let presenter = EditProfilePresenter(profile: profile)
        presenter.router = router
        presenter.output = output

        let interactor = EditProfileInteractor()
        interactor.output = presenter
        interactor.provider = provider

        let viewController = EditProfileViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
