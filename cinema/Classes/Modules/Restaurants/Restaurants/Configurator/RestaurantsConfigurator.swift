//
// Created by Alexander Maslennikov on 21/07/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class RestaurantsConfigurator {

    static let tag: String = "RestaurantsTag"

    var appRouter: AppRouterProtocol!
    var provider: RxMoyaProvider<FoodleTarget>!
    var moduleCreator: AppRouterModuleCreator!
    var locationManager: LocationManagerProtocol!

    func configureModule() -> UIViewController {
        let router = RestaurantsRouter()
        router.appRouter = appRouter

        let presenter = RestaurantsPresenter(contentFormat: .map)
        presenter.router = router
        presenter.dataCollector = RestaurantsDataCollector(itemOutput: presenter)

        let interactor = RestaurantsInteractor()
        interactor.provider = provider
        interactor.locationManager = locationManager
        interactor.output = presenter

        locationManager.output = interactor

        let map = moduleCreator.createModule(for: .restaurantsMap(output: presenter))
        let mapFlow = moduleCreator.createNavigationFlowController(viewController: map)
        let list = moduleCreator.createModule(for: .restaurantsList(output: presenter))
        let listFlow = moduleCreator.createNavigationFlowController(viewController: list)

        let viewController = RestaurantsViewController(
            controllers: [
                mapFlow.rootViewController,
                listFlow.rootViewController
            ]
        )
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
