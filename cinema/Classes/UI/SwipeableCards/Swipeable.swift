//
// Created by Xander on 02.09.17.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

protocol Swipeable {

    var coverView: UIView { get }

    func showCover(alpha: CGFloat, animationDuration: TimeInterval)

    func hideCover(animationDuration: TimeInterval)
}

// MARK: - Swipeable

extension Swipeable {

    func showCover(alpha: CGFloat, animationDuration: TimeInterval) {
        guard let superview = coverView.superview else {
            log.warning("Need add coverView")
            return
        }

        superview.bringSubview(toFront: coverView)
        coverView.alpha = 1
        coverView.isHidden = false

        UIView.animate(
            withDuration: animationDuration,
            animations: {
                self.coverView.alpha = alpha
            }
        )
    }

    func hideCover(animationDuration: TimeInterval) {
        UIView.animate(
            withDuration: animationDuration,
            animations: {
                self.coverView.alpha = 0
            },
            completion: { _ in
                self.coverView.isHidden = true
            }
        )
    }
}
