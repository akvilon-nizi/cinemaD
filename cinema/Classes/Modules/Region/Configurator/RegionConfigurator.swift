//
// Created by incetro on 24/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class RegionConfigurator {

    static let tag: String = "RegionTag"

    var appRouter: AppRouterProtocol!
    var provider: RxMoyaProvider<FoodleTarget>!
    var regionManager: RegionManager!

    var needToReturn = false
    let selectedRegion: Region?

    init(selectedRegion: Region?) {

        self.selectedRegion = selectedRegion
    }

    func configureModule() -> UIViewController {
        let router = RegionRouter()
        router.appRouter = appRouter

        let presenter = RegionPresenter(region: selectedRegion)
        presenter.router = router
        presenter.needToReturn = needToReturn

        let interactor = RegionInteractor()
        interactor.output = presenter
        interactor.provider = provider
        interactor.regionManager = regionManager

        let viewController = RegionViewController()
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
