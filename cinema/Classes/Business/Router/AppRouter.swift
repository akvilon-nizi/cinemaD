//
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
    case slides
    case start
    case authCinema
    case registration
    case newPassword
    case helpAuth
    case confirmation(phone: String, uid: String, isRestore: Bool)
    case phone(phone: String, uid: String)
    case films(films: [Film])
    case actors
    case film(videoID: String, name: String)
    case kinobase
    case main
    case newCollections(id: String, name: String, watched: [Film])

    var isPresent: Bool {
        switch self {
        case .systemAlert:
            return true
//        case let .authCode(_, needToDismiss):
//            return needToDismiss
        default:
            return false
        }
    }

    fileprivate func constructModule(in factory: DependencyContainer) -> UIViewController {
        do {
            switch self {
            case let .systemAlert(data):
                return try factory.resolve(tag: Containers.ViewControllerType.systemAlert, arguments: data)
            case .slides:
                return try factory.resolve(tag: SlidesConfigurator.tag)
            case .start:
                return try factory.resolve(tag: StartConfigurator.tag)
            case .authCinema:
                return try factory.resolve(tag: AuthCinemaConfigurator.tag)
            case .registration:
                return try factory.resolve(tag: RegistrationConfigurator.tag)
            case .newPassword:
                return try factory.resolve(tag: NewPasswordConfigurator.tag)
            case .helpAuth:
                return try factory.resolve(tag: HelpAuthConfigurator.tag)
            case let .confirmation(phone, uid, isRestore):
                return try factory.resolve(tag: ConfirmationConfigurator.tag, arguments: phone, uid, isRestore)
            case let .phone(phone, uid):
                return try factory.resolve(tag: PhoneConfigurator.tag, arguments: phone, uid)
            case let .films(films):
                return try factory.resolve(tag: FilmsConfigurator.tag, arguments: films)
            case .actors:
                return try factory.resolve(tag: ActorsConfigurator.tag)
            case let .film(videoID, name):
                return try factory.resolve(tag: FilmConfigurator.tag, arguments: videoID, name)
            case let .newCollections(id, name, watched):
                return try factory.resolve(tag: NewCollectionsConfigurator.tag, arguments: id, name, watched)
            case .kinobase:
                return try factory.resolve(tag: KinobaseConfigurator.tag)
            case .main:
                return try factory.resolve(tag: MainConfigurator.tag)
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

    func mainView()

    func starting()
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

        let authViewController = moduleCreator.createModule(for: .authCinema)

        let flowController = moduleCreator.createNavigationFlowController(viewController: authViewController)

        application.keyWindow?.rootViewController = flowController.rootViewController
    }

    func starting() {

        let authViewController = moduleCreator.createModule(for: .start)

        let flowController = moduleCreator.createNavigationFlowController(viewController: authViewController)

        if let appDelegate = application.delegate as? AppDelegate {
            appDelegate.rootFlowController = flowController
            appDelegate.window?.rootViewController = flowController.rootViewController
        }
    }

    func mainView() {

        let mainViewController = moduleCreator.createModule(for: .main)

        let flowController = moduleCreator.createNavigationFlowController(viewController: mainViewController)

        if let appDelegate = application.delegate as? AppDelegate {
            appDelegate.rootFlowController = flowController
            appDelegate.window?.rootViewController = flowController.rootViewController
        }
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
