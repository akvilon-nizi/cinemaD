//
//  UIScrollView+ParallaxHeader.swift
//  foodle
//
//  Created by incetro on 31/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - UIScrollView

extension UIScrollView {

    private struct AssociatedKey {

        static var name = "foodle.parallaxHeader"
    }

    var parallaxHeader: ParallaxHeader {

        get {

            if let header = objc_getAssociatedObject(self, &AssociatedKey.name) as? ParallaxHeader {

                return header
            }

            let header = ParallaxHeader()
            self.parallaxHeader = header
            return header
        }
        set(parallaxHeader) {

            parallaxHeader.scrollView = self

            objc_setAssociatedObject(self, &AssociatedKey.name, parallaxHeader, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
