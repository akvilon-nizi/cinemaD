//
//  Created by incetro on 08/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - ButtonTableType

enum ButtonTableType {

    case pickup
    case check
    case able

    var width: CGFloat {

        switch self {
        case .pickup, .check:
            return 118
        case .able:
            return 86
        }
    }

    var button: UIButton {

        switch self {
        case .pickup:
            return createPickupButton()
        case .check:
            return createCheckButton()
        case .able:
            return createAbleButton()
        }
    }

    private func createPickupButton() -> UIButton {

        let button = UIButton(frame: .zero)

        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor.fdlPaleGrey
        button.titleLabel?.font = UIFont.fdlGothamProMedium(size: 11)
        button.setTitleColor(UIColor.fdlCoolGrey, for: .normal)
        button.clipsToBounds = true
        button.setTitle(L10n.restaurantTableTitlePickup, for: .normal)

        return button
    }

    private func createCheckButton() -> UIButton {

        let button = UIButton(frame: .zero)

        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.fdlRedPink.cgColor
        button.titleLabel?.font = UIFont.fdlGothamProMedium(size: 11)
        button.setTitleColor(UIColor.fdlRedPink, for: .normal)
        button.clipsToBounds = true
        button.setTitle(L10n.restaurantTableTitleCheck, for: .normal)

        return button
    }

    private func createAbleButton() -> UIButton {

        let button = UIButton(frame: .zero)

        button.layer.cornerRadius = 5

        let gradient = CAGradientLayer()
        let colorLeft = UIColor.fdlWatermelon.cgColor
        let colorRight = UIColor.fdlPeachyPink.cgColor

        gradient.colors = [colorLeft, colorRight]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.05)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.05)
        gradient.frame = CGRect(x: 0, y: 0, width: 86, height: 26)
        gradient.cornerRadius = 5

        button.titleLabel?.font = UIFont.fdlGothamProMedium(size: 12)
        button.titleLabel?.textColor = .white
        button.clipsToBounds = true
        button.layer.insertSublayer(gradient, at: 0)
        button.setTitle(L10n.restaurantTableTitleAble, for: .normal)

        return button
    }
}
