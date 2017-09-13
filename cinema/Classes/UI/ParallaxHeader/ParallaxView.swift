//
//  ParallaxView.swift
//  foodle
//
//  Created by incetro on 31/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - ParallaxView

class ParallaxView: UIView {

    private let parent: ParallaxHeader

    init(parent: ParallaxHeader) {

        self.parent = parent

        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func willMove(toSuperview newSuperview: UIView?) {

        guard let scrollView = self.superview as? UIScrollView else {

            return
        }

        scrollView.removeObserver(self.parent,
                                  forKeyPath: NSStringFromSelector(#selector(getter: scrollView.contentOffset)),
                                  context: parallaxHeaderKVOContext)
    }

    override func didMoveToSuperview() {

        guard let scrollView = self.superview as? UIScrollView else {

            return
        }

        scrollView.addObserver(self.parent,
                               forKeyPath: NSStringFromSelector(#selector(getter: scrollView.contentOffset)),
                               options: NSKeyValueObservingOptions.new,
                               context: parallaxHeaderKVOContext)
    }
}
