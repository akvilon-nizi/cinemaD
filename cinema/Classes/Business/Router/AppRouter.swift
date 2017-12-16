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
    case actors(id: String, name: String, role: String, persons: [PersonFromFilm])
    case film(videoID: String, name: String)
    case kinobase
    case main
    case rewards
    case newCollections(output: NewCollectionsModuleOutput, id: String, name: String, watched: [Film])
    case filter(output: FilterModuleOutput,
        genres: [String],
        years: [Int],
        filterParameters: FilterParameters,
        isWatched: Bool
    )
    case news(newsID: String)
    case profile(mainView: MainTabView)
    case editingProfile(nameUser: String, avatar: String, output: EditingProfileModuleOutput)
    case settings
    case reviews(film: FullFilm)
    case friends
    case adminCollection(id: String, name: String)

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

    var isTabView: Bool {
        switch self {
        case .kinobase:
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
            case let .actors(id, name, role, persons):
                return try factory.resolve(tag: ActorsConfigurator.tag, arguments: id, name, role, persons)
            case let .film(videoID, name):
                return try factory.resolve(tag: FilmConfigurator.tag, arguments: videoID, name)
            case let .newCollections(output, id, name, watched):
                return try factory.resolve(tag: NewCollectionsConfigurator.tag, arguments: output, id, name, watched)
            case .kinobase:
                return try factory.resolve(tag: KinobaseConfigurator.tag)
            case .main:
                return try factory.resolve(tag: MainConfigurator.tag)
            case let .filter(output, genres, years, filterParameters, isWatched):
                return try factory.resolve(tag: FilterConfigurator.tag, arguments: output, genres, years, filterParameters, isWatched)
            case let .news(newsID):
                return try factory.resolve(tag: NewsConfigurator.tag, arguments: newsID)
            case .rewards:
                return try factory.resolve(tag: RewardsConfigurator.tag)
            case .friends:
                return try factory.resolve(tag: FriendsConfigurator.tag)
            case let .profile(mainView):
                return try factory.resolve(tag: ProfileConfigurator.tag, arguments: mainView)
            case let .editingProfile(nameUser, avatar, output):
                return try factory.resolve(tag: EditingProfileConfigurator.tag, arguments: nameUser, avatar, output)
            case .settings:
                return try factory.resolve(tag: SettingsConfigurator.tag)
            case let .reviews(film):
                return try factory.resolve(tag: ReviewsConfigurator.tag, arguments: film)
            case let .adminCollection(id, name):
                return try factory.resolve(tag: AdminCollectionConfigurator.tag, arguments: id, name)
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

    func backToMain()

    func dropAll()

    func mainView()

    func starting()

    func setRootViewController(viewControler: UINavigationController)
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
        } else if destination.isTabView {
            flowController.performTransitionFromMain(to: viewController, animated: true)
                .subscribe()
                .addDisposableTo(disposeBag)
        } else {
            flowController.performTransition(to: viewController, animated: true)
                .subscribe()
                .addDisposableTo(disposeBag)
        }
    }

    func backToMain() {
        guard let flowController = dataSource?.flowControllerForTransition() else {
            log.warning("can't receive flow controller for transition")
            return
        }
        flowController.performTransitionToMain(animated: true)
            .subscribe()
            .addDisposableTo(disposeBag)
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

    func setRootViewController(viewControler: UINavigationController) {
        guard let flowController = dataSource?.flowControllerForTransition() else {
            log.warning("can't receive flow controller for transition")
            return
        }
//        let navigationController = UINavigationController(rootViewController: viewControler)
        flowController.rootViewController = viewControler

        if let appDelegate = application.delegate as? AppDelegate {
            appDelegate.rootFlowController = flowController
        }
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
