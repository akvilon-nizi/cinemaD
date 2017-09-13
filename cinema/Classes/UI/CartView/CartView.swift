//
//  CartView.swift
//  foodle
//
//  Created by incetro on 17/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

protocol CartViewDelegate: class {

    func didTapCartButton()
}

// MARK: - CartView

class CartView: UIView {

    private let expandWidth: CGFloat = 6

    weak var delegate: CartViewDelegate?

    private var labelWidthConstraint: NSLayoutConstraint?

    private let countLabel: UILabel = {

        let countLabel = UILabel()

        countLabel.textColor = .white
        countLabel.layer.backgroundColor = UIColor.fdlSalmonPink.cgColor
        countLabel.font = UIFont.fdlSystemRegular(size: 10)
        countLabel.textAlignment = .center
        countLabel.layer.cornerRadius = 6

        return countLabel
    }()

    private let cartButton: UIButton = {

        let cartButton = UIButton()

        cartButton.setImage(Asset.Restaurant.restaurantMenuCart.image, for: .normal)
        cartButton.addTarget(self, action: #selector(didTapCartButton), for: .touchUpInside)

        return cartButton
    }()

    func didTapCartButton() {

        delegate?.didTapCartButton()
    }

    func updateCount(_ cnt: Int) {

        countLabel.isHidden = cnt < 1

        guard cnt > 0 else {

            return
        }

        countLabel.text = "\(cnt)"

        let labelWidth = countLabel.intrinsicContentSize.width

        labelWidthConstraint?.constant = labelWidth + expandWidth
    }

    override init(frame: CGRect) {

        super.init(frame: frame)

        addSubview(cartButton.prepareForAutoLayout())
        addSubview(countLabel.prepareForAutoLayout())

        cartButton.pinEdgesToSuperviewEdges()

        countLabel.pinToSuperview([.left, .bottom])

        let labelWidth = countLabel.intrinsicContentSize.width

        labelWidthConstraint = countLabel.widthAnchor.constraint(equalToConstant: labelWidth + expandWidth)
        labelWidthConstraint?.isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
