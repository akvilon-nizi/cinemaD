//
// Created by Александр Масленников on 24.07.17.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import Dip
import RxSwift

struct AlertControllerData {
    var title: String?
    var message: String?
    var actions: [UIAlertAction]
}

enum AppRouterDestination {
    case systemAlert(data: AlertControllerData)
    case authPhone
    case restaurants
    case restaurantsMap(output: RestaurantsMapModuleOutput?)
    case restaurantsList(output: RestaurantsListModuleOutput?)
    case restaurant(id: Int)
    case restaurantMenu(selectedCategoryID: Int, restaurant: FullRestaurant)
    case cart
    case authCode(phone: String, needToDismiss: Bool)
    case categoryMenu(categoryID: Int, restaurant: FullRestaurant)
    case region(selectedRegion: Region?, needToReturn: Bool)
    case terms
    case profile
    case editProfile(profile: Profile, output: EditProfileModuleOutput)
    case slides
    case cardOfProduct(productID: Int)
    case myOrder

    var isPresent: Bool {
        switch self {
        case .systemAlert:
            return true
        case let .authCode(_, needToDismiss):
            return needToDismiss
        default:
            return false
        }
    }

    fileprivate func constructModule(in factory: DependencyContainer) -> UIViewController {
        do {
            switch self {
            case let .systemAlert(data):
                return try factory.resolve(tag: Containers.ViewControllerType.systemAlert, arguments: data)
            case .authPhone:
                return try factory.resolve(tag: AuthPhoneConfigurator.tag)
            case .restaurants:
                return try factory.resolve(tag: RestaurantsConfigurator.tag)
            case let .restaurantsMap(output):
                return try factory.resolve(tag: RestaurantsMapConfigurator.tag, arguments: output)
            case let .restaurantsList(output):
                return try factory.resolve(tag: RestaurantsListConfigurator.tag, arguments: output)
            case let .restaurant(id):
                return try factory.resolve(tag: RestaurantConfigurator.tag, arguments: id)
            case let .restaurantMenu(selectedCategoryID, restaurant):
                return try factory.resolve(tag: RestaurantMenuConfigurator.tag, arguments: selectedCategoryID, restaurant)
            case .cart:
                return try factory.resolve(tag: CartConfigurator.tag)
            case let .authCode(phone, needToDismiss):
                return try factory.resolve(tag: AuthCodeConfigurator.tag, arguments: phone, needToDismiss)
            case let .categoryMenu(categoryID, restaurant):
                return try factory.resolve(tag: CategoryMenuConfigurator.tag, arguments: categoryID, restaurant)
            case let .region(region, needToReturn):
                return try factory.resolve(tag: RegionConfigurator.tag, arguments: region, needToReturn)
            case .terms:
                return try factory.resolve(tag: TermsConfigurator.tag)
            case .profile:
                return try factory.resolve(tag: ProfileConfigurator.tag)
            case let .editProfile(profile, output):
                return try factory.resolve(tag: EditProfileConfigurator.tag, arguments: profile, output)
            case .slides:
                return try factory.resolve(tag: SlidesConfigurator.tag)
            case let .cardOfProduct(productID):
                return try factory.resolve(tag: CardOfProductConfigurator.tag, arguments: productID)
            case .myOrder:
                return try factory.resolve(tag: MyOrderConfigurator.tag)
            }
        } catch {
            fatalError("can't resolve module from factory")
        }
    }
}

protocol AppRouterProtocol {
    func transition(to destination: AppRouterDestination)

    func simpleTransition(to destination: AppRouterDestination)

    func dismissModule()

    func backTransition()

    func openSideMenu()

    func dropAll()
}

protocol AppRouterFlowControllerDataSource: class {
    func flowControllerForTransition() -> FlowControllerProtocol?
}

protocol AppRouterModuleCreator {
    func createModule(for destination: AppRouterDestination) -> UIViewController

    func createNavigationFlowController(viewController: UIViewController) -> FlowControllerProtocol
}

class AppRouter: AppRouterProtocol {

    fileprivate let disposeBag = DisposeBag()
    let application: UIApplication
    let factory: DependencyContainer
    let moduleCreator: AppRouterModuleCreator
    weak var dataSource: AppRouterFlowControllerDataSource?

    init(application: UIApplication, factory: DependencyContainer, moduleCreator: AppRouterModuleCreator) {
        self.application = application
        self.factory = factory
        self.moduleCreator = moduleCreator
    }

    func transition(to destination: AppRouterDestination) {
        guard let flowController = dataSource?.flowControllerForTransition() else {
            log.warning("can't receive flow controller for transition")
            return
        }

        let vc = moduleCreator.createModule(for: destination)
        transition(to: vc, flowController: flowController, destination: destination)
    }

    func simpleTransition(to destination: AppRouterDestination) {
        guard let flowController = dataSource?.flowControllerForTransition() else {
            log.warning("can't receive flow controller for transition")
            return
        }

        flowController.performTransition(to: destination).subscribe().addDisposableTo(disposeBag)
    }

    private func transition(
        to viewController: UIViewController,
        flowController: FlowControllerProtocol,
        destination: AppRouterDestination) {

        log.info("launch transition to view controller")

        if destination.isPresent {
            let childFlowController = moduleCreator.createNavigationFlowController(viewController: viewController)
            flowController.present(childFlowController: childFlowController, animated: true)
                .subscribe()
                .addDisposableTo(disposeBag)
        } else {
            flowController.performTransition(to: viewController, animated: true)
                .subscribe()
                .addDisposableTo(disposeBag)
        }
    }

    func openSideMenu() {
    }

    func dropAll() {

        let authViewController = moduleCreator.createModule(for: .authPhone)

        let flowController = moduleCreator.createNavigationFlowController(viewController: authViewController)

        application.keyWindow?.rootViewController = flowController.rootViewController
    }

    func backTransition() {
        guard let flowController = dataSource?.flowControllerForTransition() else {
            log.warning("can't receive flow controller for transition")
            return
        }

        flowController.performBackTransition(animated: true)
            .subscribe()
            .addDisposableTo(disposeBag)
    }

    func dismissModule() {
        guard let flowController = dataSource?.flowControllerForTransition() else {
            log.warning("can't receive flow controller for transition")
            return
        }

        flowController.dismissChildFlowController(animated: true)
            .subscribe()
            .addDisposableTo(disposeBag)
    }
}

class ModuleCreator: AppRouterModuleCreator {

    let factory: DependencyContainer

    init(factory: DependencyContainer) {
        self.factory = factory
    }

    func createModule(for destination: AppRouterDestination) -> UIViewController {
        return destination.constructModule(in: factory)
    }

    func createNavigationFlowController(viewController: UIViewController) -> FlowControllerProtocol {
        return NavigationFlowController(rootViewController: viewController, moduleCreator: self)
    }
}
