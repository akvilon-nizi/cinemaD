//
// Created by Александр Масленников on 06.08.17.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxSwift

protocol BaseRouterInput {

    var appRouter: AppRouterProtocol! { get }

    func performTransitionToNetworkAlert(message: String?, actions: [UIAlertAction])

    func performTransitionToSystemAlert(title: String?, message: String?, actions: [UIAlertAction])
}

extension BaseRouterInput {

    func performTransitionToNetworkAlert(message: String?, actions: [UIAlertAction] = []) {
        performTransitionToSystemAlert(title: L10n.alertTitleNetworkError, message: message, actions: actions)
    }

    func performTransitionToSystemAlert(title: String?, message: String?, actions: [UIAlertAction]) {
        var newActions = actions
        if actions.isEmpty {
            newActions.append(UIAlertAction(title: L10n.alertButtonCancel, style: .cancel, handler: nil))
        }
        appRouter.simpleTransition(to: .systemAlert(data: AlertControllerData(
            title: title,
            message: message,
            actions: newActions
        )))
    }
}
