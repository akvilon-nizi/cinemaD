//
//  ShadowView.swift
//  foodle
//
//  Created by incetro on 08/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - ShadowView

class ShadowView: UIView {

    var cornerRadius: CGFloat = 5 {

        didSet {

            layer.cornerRadius = cornerRadius
        }
    }

    var shadowOffsetWidth: Int = -1 {

        didSet {

            layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        }
    }

    var shadowOffsetHeight: Int = 1 {

        didSet {

            layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        }
    }

    var shadowColor = UIColor.fdlWarmGrey {

        didSet {

            layer.shadowColor = shadowColor.cgColor
        }
    }

    var shadowOpacity: Float = 0.25 {

        didSet {

            layer.shadowOpacity = shadowOpacity
        }
    }

    override func layoutSubviews() {

        super.layoutSubviews()

        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)

        layer.masksToBounds = false
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
        layer.shadowRadius = 10
    }
}
