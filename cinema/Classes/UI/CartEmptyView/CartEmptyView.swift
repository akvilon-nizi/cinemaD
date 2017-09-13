//
//  CartEmptyView.swift
//  foodle
//
//  Created by incetro on 18/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - CartEmptyViewDelegate

protocol CartEmptyViewDelegate: class {

    func didTapRestaurantsButton()
}

// MARK: - CartEmptyView

class CartEmptyView: UIView {

    private static let buttonSize: (width: CGFloat, height: CGFloat) = (width: 150, height: 40)

    weak var delegate: CartEmptyViewDelegate?

    let imageView: UIImageView = {

        let imageView = UIImageView()

        imageView.image = Asset.Cart.cartEmptyPlaceholder.image
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    let titleLabel: UILabel = {

        let titleLabel = UILabel()

        titleLabel.font = UIFont.fdlGothamProMedium(size: 20)
        titleLabel.text = L10n.cartEmptyTitle

        return titleLabel
    }()

    let messageLabel: UILabel = {

        let messageLabel = UILabel()

        messageLabel.font = UIFont.fdlGothamProMedium(size: 14)
        messageLabel.text = L10n.cartEmptyMessage

        return messageLabel
    }()

    let button: UIButton = {

        let button = UIButton()

        button.layer.cornerRadius = 5

        let gradient = CAGradientLayer()
        let colorLeft = UIColor.fdlWatermelon.cgColor
        let colorRight = UIColor.fdlPeachyPink.cgColor

        gradient.colors = [colorLeft, colorRight]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.05)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.05)
        gradient.frame = CGRect(x: 0, y: 0, width: CartEmptyView.buttonSize.width, height: CartEmptyView.buttonSize.height)
        gradient.cornerRadius = 5

        button.titleLabel?.font = UIFont.fdlGothamProMedium(size: 15)
        button.titleLabel?.textColor = .white
        button.clipsToBounds = true
        button.layer.insertSublayer(gradient, at: 0)
        button.setTitle(L10n.cartButtonTitle, for: .normal)

        return button
    }()

    override init(frame: CGRect) {

        super.init(frame: frame)

        addSubview(imageView.prepareForAutoLayout())

        imageView.heightAnchor ~= 164
        imageView.widthAnchor ~= 164
        imageView.centerXAnchor ~= centerXAnchor
        imageView.topAnchor ~= topAnchor + 60

        addSubview(titleLabel.prepareForAutoLayout())

        titleLabel.topAnchor ~= imageView.bottomAnchor + 57
        titleLabel.centerXAnchor ~= centerXAnchor

        addSubview(messageLabel.prepareForAutoLayout())

        messageLabel.topAnchor ~= titleLabel.bottomAnchor + 13
        messageLabel.centerXAnchor ~= centerXAnchor

        addSubview(button.prepareForAutoLayout())

        button.centerXAnchor ~= centerXAnchor
        button.bottomAnchor ~= bottomAnchor - 80
        button.widthAnchor ~= CartEmptyView.buttonSize.width
        button.heightAnchor ~= CartEmptyView.buttonSize.height

        button.addTarget(self, action: #selector(didTapRestaurantsButton), for: .touchUpInside)
    }

    func didTapRestaurantsButton() {

        delegate?.didTapRestaurantsButton()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
