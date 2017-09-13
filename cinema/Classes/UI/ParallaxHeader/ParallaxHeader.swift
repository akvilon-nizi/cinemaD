//
//  ParallaxHeader.swift
//  foodle
//
//  Created by incetro on 31/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

let parallaxHeaderKVOContext = UnsafeMutableRawPointer.allocate(bytes: 4, alignedTo: 1)

// MARK: - ParallaxHeader

class ParallaxHeader: NSObject {

    var parallaxDidScrollHandler: ((ParallaxHeader) -> Void)?

    var scrollView: UIScrollView? {

        didSet {

            guard let scrollView = scrollView else {

                return
            }

            adjustScrollViewTopInset(top: scrollView.contentInset.top + height)

            scrollView.addSubview(contentView)

            layoutContentView()
        }
    }

    private lazy var contentView: UIView = {

        let contentView = ParallaxView(parent: self)

        contentView.clipsToBounds = true

        return contentView
    }()

    var view: UIView? {

        didSet {

            updateConstraints()
        }
    }

    var mode: ParallaxHeaderMode = .fill {

        didSet {

            updateConstraints()
        }
    }

    private var currentHeight: CGFloat = 0

    var height: CGFloat {

        get {

            return currentHeight
        }

        set(height) {

            guard currentHeight != height, let scrollView = scrollView else {

                return
            }

            adjustScrollViewTopInset(top: scrollView.contentInset.top - currentHeight + height)

            currentHeight = height

            updateConstraints()
            layoutContentView()
        }
    }

    var minimumHeight: CGFloat = 0 {

        didSet {

            layoutContentView()
        }
    }

    var progress: CGFloat = 0 {

        didSet {

            parallaxDidScrollHandler?(self)
        }
    }

    private func updateConstraints(update: Bool = false) {

        if !update {

            if let view = view {

                view.removeFromSuperview()
                contentView.addSubview(view.prepareForAutoLayout())
            }
        }

        switch mode {

        case .fill:
            setFillModeConstraints()

        case .top:
            setTopModeConstraints()

        case .topFill:
            setTopFillModeConstraints()

        case .center:
            setCenterModeConstraints()

        case .centerFill:
            setCenterFillModeConstraints()

        case .bottom:
            setBottomModeConstraints()

        case .bottomFill:
            setBottomFillModeConstraints()
        }
    }

    private func setFillModeConstraints() {

        guard let view = view else {

            return
        }

        view.pin(to: contentView)
    }

    private func setTopModeConstraints() {

        guard let view = view else {

            return
        }

        view.pin(as: contentView, using: [.left, .top, .right])
        view.heightAnchor ~= height
    }

    private func setTopFillModeConstraints() {

        guard let view = view else {

            return
        }

        view.pin(as: contentView, using: [.left, .top, .right])
        view.heightAnchor >= height
    }

    private func setCenterModeConstraints() {

        guard let view = view else {

            return
        }

        view.pin(to: contentView)
        view.centerXAnchor ~= contentView.centerXAnchor
        view.centerYAnchor ~= contentView.centerYAnchor
    }

    private func setCenterFillModeConstraints() {

        guard let view = view else {

            return
        }

        view.pin(to: contentView)
        view.heightAnchor >= height
        view.centerXAnchor ~= contentView.centerXAnchor
        view.centerYAnchor ~= contentView.centerYAnchor
    }

    private func setBottomModeConstraints() {

        guard let view = view else {

            return
        }

        view.pin(as: contentView, using: [.left, .bottom, .right])
        view.heightAnchor ~= height
    }

    private func setBottomFillModeConstraints() {

        guard let view = view else {

            return
        }

        view.pin(as: contentView, using: [.left, .bottom, .right])
        view.heightAnchor >= height
    }

    private func layoutContentView() {

        guard let scrollView = scrollView else {

            return
        }

        let minimumHeight = min(self.minimumHeight, self.height)
        let relativeYOffset = scrollView.contentOffset.y + scrollView.contentInset.top - height
        let relativeHeight = -relativeYOffset

        let frame = CGRect(x: 0, y: relativeYOffset, width: scrollView.frame.size.width, height: max(relativeHeight, minimumHeight))
        contentView.frame = frame

        let div = self.height - self.minimumHeight
        progress = (self.contentView.frame.size.height - self.minimumHeight) / div
    }

    private func adjustScrollViewTopInset(top: CGFloat) {

        guard let scrollView = scrollView else {

            return
        }

        var inset = scrollView.contentInset

        var offset = scrollView.contentOffset
        offset.y += inset.top - top
        scrollView.contentOffset = offset

        inset.top = top
        scrollView.contentInset = inset
    }

    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {

        guard context == parallaxHeaderKVOContext, let scrollView = scrollView else {

            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }

        if keyPath == NSStringFromSelector(#selector(getter: scrollView.contentOffset)) {

            layoutContentView()
        }
    }
}
