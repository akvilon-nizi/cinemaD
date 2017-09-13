//
// Created by Александр Масленников on 22.08.17.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

enum IndicationType {
    case load
    case error
}

protocol IndicationProtocol {

    func show(type: IndicationType, animated: Bool)

    func hide(animated: Bool)

    func updateError(message: String)
}

protocol IndicationOutput: class {

    func reloadPressed(in indication: Indication)
}

class Indication {

    var insets: UIEdgeInsets
    var animationDuration: TimeInterval = 0.25

    let containerView = UIView()

    weak var output: IndicationOutput?

    fileprivate var registeredViews: [IndicationType: UIView] = [:]

    fileprivate var lastErrorMessage: String = ""
    fileprivate var lastShowedType: IndicationType?

    init(insets: UIEdgeInsets = .zero) {
        self.insets = insets
    }

    func showHiddenState() {
        if registeredViews[.error] != nil {
            updateError(message: lastErrorMessage)
        }

        if let type = lastShowedType {
            show(type: type, animated: false)
        } else {
            hide(animated: false)
        }
    }
}

// MARK: - Fileprivate methods

extension Indication {

    func animateShow(type: IndicationType) {
        guard let view = registeredViews[type] else {
            log.warning("IndicatorView for tag-\(type) not found")
            return
        }

        var previousView: UIView?
        if containerView.subviews.count > 1 {
            previousView = containerView.subviews[containerView.subviews.count - 2]
        }

        containerView.alpha = containerView.subviews.isEmpty ? 0 : 1
        view.alpha = 0
        previousView?.alpha = 1

        UIView.animate(
            withDuration: animationDuration,
            animations: {
                self.containerView.alpha = 1
                view.alpha = 1
                previousView?.alpha = 0
            }
        )
    }

    func animateHide() {
        UIView.animate(
            withDuration: animationDuration,
            animations: {
                self.containerView.alpha = 0
            },
            completion: { _ in
                self.registeredViews.forEach {
                    $1.alpha = 0
                }
                self.containerView.isHidden = true
            }
        )
    }
}

// MARK: - IndicationProtocol

extension Indication: IndicationProtocol {

    func register(view: UIView, for type: IndicationType) {
        if let view = registeredViews[type] {
            view.removeFromSuperview()
        }
        registeredViews[type] = view

        if var errorView = view as? IndicationErrorInput {
            errorView.output = self
        }

        containerView.addSubview(view.prepareForAutoLayout())
        view.pin(to: containerView, edgesInsets: insets)
    }

    func show(type: IndicationType, animated: Bool) {
        guard let view = registeredViews[type] else {
            log.warning("IndicatorView for tag-\(type) not found")
            return
        }

        lastShowedType = type

        containerView.bringSubview(toFront: view)

        if animated {
            animateShow(type: type)
        } else {
            view.alpha = 1
        }

        if let superview = containerView.superview {
            superview.bringSubview(toFront: containerView)
        }

        containerView.isHidden = false
    }

    func hide(animated: Bool) {
        lastShowedType = nil
        lastErrorMessage = ""

        if animated {
            animateHide()
        } else {
            registeredViews.forEach {
                $1.alpha = 0
            }
            containerView.isHidden = true
        }
    }

    func updateError(message: String) {
        guard let view = registeredViews[.error] else {
            log.warning("IndicatorView for tag-error not found")
            return
        }

        lastErrorMessage = message

        if let errorView = view as? IndicationErrorInput {
            errorView.update(message: message)
        }
    }
}

// MARK: - IndicationErrorOutput

extension Indication: IndicationErrorOutput {

    func reloadPressed(in view: UIView) {
        output?.reloadPressed(in: self)
    }
}
