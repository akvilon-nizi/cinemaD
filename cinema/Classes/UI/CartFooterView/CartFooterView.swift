//
//  CartFooterView.swift
//  foodle
//
//  Created by incetro on 17/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - CartFooterView

class CartFooterView: UIView {

    private let inset: CGFloat = 18

    private let confirmButton: UIButton = {

        let confirmButton = UIButton()

        confirmButton.layer.backgroundColor = UIColor.fdlPaleGrey.cgColor
        confirmButton.layer.cornerRadius = 6
        confirmButton.setTitle(L10n.cartConfirmButtonTitle, for: .normal)
        confirmButton.setTitleColor(UIColor.fdlGreyishBrown, for: .normal)

        return confirmButton
    }()

    private let priceLabel: UILabel = {

        let priceLabel = UILabel()

        priceLabel.font = UIFont.fdlGothamProMedium(size: 24)
        priceLabel.textColor = UIColor.fdlGreyishBrown

        return priceLabel
    }()

    private let weightLabel: UILabel = {

        let weightLabel = UILabel()

        weightLabel.font = UIFont.fdlSystemRegular(size: 12)
        weightLabel.textColor = UIColor.fdlWarmGrey

        return weightLabel
    }()

    func setData(_ item: CartFooterItem) {

        priceLabel.text = item.price
        weightLabel.text = item.weight
    }

    override init(frame: CGRect) {

        super.init(frame: frame)

        addSubview(confirmButton.prepareForAutoLayout())

        confirmButton.centerYAnchor ~= centerYAnchor
        confirmButton.widthAnchor ~= 154
        confirmButton.trailingAnchor ~= trailingAnchor - inset
        confirmButton.heightAnchor ~= 46

        addSubview(priceLabel.prepareForAutoLayout())

        priceLabel.leadingAnchor ~= leadingAnchor + inset
        priceLabel.topAnchor ~= confirmButton.topAnchor

        addSubview(weightLabel.prepareForAutoLayout())

        weightLabel.leadingAnchor ~= leadingAnchor + inset
        weightLabel.bottomAnchor ~= confirmButton.bottomAnchor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
