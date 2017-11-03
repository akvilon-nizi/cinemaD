//
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxSwift
import Dip

enum NavigationFlowControllerError: Error {
    case wrongRootViewController
}

final class NavigationFlowController {

    var rootViewController: UIViewController

    var childFlowControllers: [FlowControllerProtocol]?

    weak var parentFlowController: FlowControllerProtocol?

    let moduleCreator: ModuleCreator

    init(rootViewController vc: UIViewController, moduleCreator: ModuleCreator) {
        let navigationController = UINavigationController(rootViewController: vc)
        rootViewController = navigationController
        self.moduleCreator = moduleCreator

        let decorator = WhiteNavigationBarDecorator()
        decorator.configure(navigationController.navigationBar)
    }
}

extension NavigationFlowController: FlowControllerProtocol {

    func performTransition(to viewController: UIViewController, animated: Bool = true) -> FlowControllerResult {
        return Observable.create { (observer: AnyObserver<UIViewController?>) in
            guard let navigationController = self.rootViewController as? UINavigationController else {
                observer.onError(NavigationFlowControllerError.wrongRootViewController)
                return Disposables.create()
            }
            navigationController.push(viewController: viewController, animated: animated) {
                observer.onNext(viewController)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }

    func performTransition(to destination: AppRouterDestination) -> FlowControllerResult {
        return Observable.create { observer in
            guard let navigationController = self.rootViewController as? UINavigationController else {
                observer.onError(NavigationFlowControllerError.wrongRootViewController)
                return Disposables.create()
            }
            let viewController = self.moduleCreator.createModule(for: destination)
            viewController.hidesBottomBarWhenPushed = true
            observer.on(Event.next(viewController))
            if destination.isPresent {
                navigationController.present(viewController, animated: true, completion: {
                    observer.on(Event.completed)
                })
            } else {
                navigationController.push(viewController: viewController, animated: true, completion: {
                    observer.on(Event.completed)
                })
            }
            return Disposables.create()
        }
    }

    func performBackTransition(animated: Bool = true) -> FlowControllerResult {
        return Observable.create { (observer: AnyObserver<UIViewController?>) in
            guard let navigationController = self.rootViewController as? UINavigationController else {
                observer.onError(NavigationFlowControllerError.wrongRootViewController)
                return Disposables.create()
            }
            navigationController.pop(animated: animated) {
                observer.onNext(nil)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}

fileprivate extension UINavigationController {

    func push(viewController: UIViewController, animated: Bool, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }

    func pop(animated: Bool, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: animated)
        CATransaction.commit()
    }
}
