//
// Created by Александр Масленников on 21.07.17.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxSwift

typealias FlowControllerResult = Observable<UIViewController?>

protocol FlowControllerProtocol: class {

    var rootViewController: UIViewController { get }

    var childFlowControllers: [FlowControllerProtocol]? { get set }

    weak var parentFlowController: FlowControllerProtocol? { get set }

    func performTransition(to viewController: UIViewController, animated: Bool) -> FlowControllerResult

    func performTransition(to destination: AppRouterDestination) -> FlowControllerResult

    func performBackTransition(animated: Bool) -> FlowControllerResult

    func present(childFlowController: FlowControllerProtocol, animated: Bool) -> FlowControllerResult

    func presentRoot(childFlowController: FlowControllerProtocol, animated: Bool) -> FlowControllerResult

    func dismissChildFlowController(animated: Bool) -> FlowControllerResult
}

extension FlowControllerProtocol {
    func presentRoot(childFlowController: FlowControllerProtocol, animated: Bool) -> FlowControllerResult {
        return present(childFlowController: childFlowController, animated: animated)
    }

    func present(childFlowController: FlowControllerProtocol, animated: Bool = true) -> FlowControllerResult {
        return dismissChildFlowController(animated: animated)
            .flatMap { _ in
                Observable.create { (observer: AnyObserver<UIViewController?>) in
                    self.childFlowControllers = [childFlowController]
                    childFlowController.parentFlowController = self
                    self.rootViewController.present(childFlowController.rootViewController, animated: animated) {
                        observer.onNext(childFlowController.rootViewController)
                        observer.onCompleted()
                    }
                    return Disposables.create()
                }
            }
    }

    func dismissChildFlowController(animated: Bool = true) -> FlowControllerResult {
        return Observable.create { (observer: AnyObserver<UIViewController?>) in
            guard self.rootViewController.presentedViewController != nil else {
                observer.onNext(nil)
                observer.onCompleted()
                return Disposables.create()
            }
            self.rootViewController.dismiss(animated: animated) {
                self.childFlowControllers = nil
                observer.onNext(nil)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
