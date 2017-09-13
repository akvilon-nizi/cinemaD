//
//  RestaurantNavigationBarView.swift
//  foodle
//
//  Created by incetro on 11/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - RestaurantNavigationBarView

class RestaurantNavigationBarView: UIView {

    private let nameLabel = UILabel()
    private let addressLabel = UILabel()

    private let nameFontSize: CGFloat = 20
    private let addressFontSize: CGFloat = 15

    func setup(withName name: String, address: String, nameAlpha: CGFloat = 0, addressAlpha: CGFloat = 0) {

        addSubview(nameLabel)
        addSubview(addressLabel)

        nameLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height - addressFontSize)

        addressLabel.frame = CGRect(x: 0, y: self.frame.height - 20, width: self.frame.width, height: addressFontSize)

        nameLabel.textAlignment = .center
        addressLabel.textAlignment = .center

        nameLabel.alpha = nameAlpha
        addressLabel.alpha = addressAlpha

        addressLabel.font = UIFont.fdlSystemRegular(size: addressFontSize)
        nameLabel.font = UIFont.fdlGothamProMedium(size: nameFontSize)

        nameLabel.text = name
        addressLabel.text = address
    }

    func updateAlpha(withOffset offset: CGFloat) {

        let firstViewIndent: CGFloat = 60
        let secondViewIndent: CGFloat = 90

        alpha = min(offset / 42.0, 1)

        nameLabel.alpha = offset >= firstViewIndent ? (offset - firstViewIndent) / firstViewIndent : 0
        addressLabel.alpha = offset >= secondViewIndent ? (offset - secondViewIndent) / secondViewIndent : 0
    }
}
