//
//  StatusBarAlertManager.swift
//  cinema
//
//  Created by iOS on 20.12.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import Foundation
import UIKit

enum StatusBarMessageType: Int {
    case success
    case failure
    case request
}

class StatusBarAlertManager {
    static let sharedInstance = StatusBarAlertManager()

    fileprivate let window = StatusBarWindow(frame: CGRect.zero)
    fileprivate let animationID = "StatusBarAlertManagerAnimationID"
    fileprivate var alertMessage: String?
    fileprivate var viewControllers: [UIViewController] = [UIViewController]()

    // MARK: - Public

    func registrate(viewController: UIViewController) {
        guard viewControllers.index(of: viewController) == nil else {
            return
        }

        viewControllers.append(viewController)
    }

    func unregistrate(viewController: UIViewController) {

        clear()

        if let index = viewControllers.index(of: viewController) {
            viewControllers.remove(at: index)
        }
    }

    func setStatusBarAlert(with message: String, withType type: StatusBarMessageType = .failure, with viewController: UIViewController) {

//        guard viewControllers.index(of: viewController) != nil else {
//            return
//        }

        guard !message.isEmpty else {
            clear()
            return
        }

        guard message != alertMessage else {
            return
        }

        alertMessage = message

        var backgroundColor: UIColor
        switch type {
        case .success:
            backgroundColor = UIColor.green.withAlphaComponent(0.5)
        case .failure:
            backgroundColor = UIColor.gray.withAlphaComponent(0.9)
        case .request:
            backgroundColor = UIColor.yellow.withAlphaComponent(0.5)
        }

        let label = createMessageLabel(text: message, backgroundColor: backgroundColor)
        UIView.performWithoutAnimation {
            label.alpha = 0
        }

        beginChanges(animated: true)

        deleteSubviewsFromWindow()

        window.addSubview(label)
        label.alpha = 1

        commitChanges()

    }

    func clear() {

        alertMessage = nil

        beginChanges(animated: true)

        deleteSubviewsFromWindow()

        commitChanges()
    }

    // MARK: - Manage animation

    fileprivate func beginChanges(animated: Bool) {
        let duration = 0.3

        UIView.beginAnimations(animationID, context: nil)
        UIView.setAnimationDuration(animated ? duration : 0)
        UIView.setAnimationDelay(0.0)
        UIView.setAnimationCurve(UIViewAnimationCurve.easeInOut)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationDidStop(#selector(StatusBarAlertManager.windowAnimationDidStop(_:finished:context:)))

    }

    fileprivate func commitChanges() {
        UIView.commitAnimations()
    }

    fileprivate dynamic func windowAnimationDidStop(_ animationID: String?, finished: Bool, context: UnsafeMutableRawPointer) {
        let views = window.subviews
        for view in views where view.alpha == 0 {
            view.removeFromSuperview()
        }
    }

    // MARK: - Helpers

    fileprivate func deleteSubviewsFromWindow() {
        for view in window.subviews {
            view.alpha = 0
        }
    }

    private func createMessageLabel (text: String, backgroundColor: UIColor) -> UILabel {
        let label = UILabel(frame: window.bounds)
        label.textAlignment = .center
        label.font = UIFont.cnmFutura(size: 14)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.text = text
        label.backgroundColor = backgroundColor
        return label
    }

}

class StatusBarWindow: UIWindow {

    override init(frame: CGRect) {
        super.init(frame: UIApplication.shared.statusBarFrame)
        self.windowLevel = UIWindowLevelStatusBar + 1.0
        self.backgroundColor = UIColor.clear

        let viewController = UIViewController()
        viewController.view.backgroundColor = UIColor.clear

        self.rootViewController = viewController

        self.makeKeyAndVisible()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
