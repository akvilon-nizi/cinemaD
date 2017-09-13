//
//  CartCell.swift
//  foodle
//
//  Created by incetro on 18/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - CartCellDelegate

protocol CartCellDelegate: class {

    func plusButtonTapped(item: CartCellItem)

    func minusButtonTapped(item: CartCellItem)
}

// MARK: - CartCell

class CartCell: UITableViewCell {

    weak var delegate: CartCellDelegate?

    private let inset: CGFloat = 6

    private let backView: ShadowView = {

        let backView = ShadowView()

        backView.backgroundColor = .white
        backView.shadowOpacity = 0.3

        return backView
    }()

    private let foodImageView: UIImageView = {

        let foodImageView = UIImageView()

        foodImageView.contentMode = .scaleAspectFill
        foodImageView.backgroundColor = .black
        foodImageView.layer.cornerRadius = 5
        foodImageView.clipsToBounds = true

        return foodImageView
    }()

    private let nameLabel: UILabel = {

        let nameLabel = UILabel()

        nameLabel.font = UIFont.fdlSystemRegular(size: 15)
        nameLabel.textColor = UIColor.fdlWarmGrey

        return nameLabel
    }()

    private let weightLabel: UILabel = {

        let weightLabel = UILabel()

        weightLabel.font = UIFont.fdlSystemRegular(size: 12)
        weightLabel.textColor = UIColor.fdlGreyishBrown

        return weightLabel
    }()

    private let priceLabel: UILabel = {

        let priceLabel = UILabel()

        priceLabel.font = UIFont.fdlGothamProMedium(size: 20)
        priceLabel.textColor = UIColor.fdlGreyishBrown

        return priceLabel
    }()

    private let countView: ProductCountView = {

        let countView = ProductCountView()

        return countView
    }()

    private var weightLabelConstraint: NSLayoutConstraint?
    private var priceLabelConstraint: NSLayoutConstraint?

    fileprivate var item: CartCellItem?

    func setData(_ item: CartCellItem) {

        self.item = item

        setupBackView()
        setupFoodImageView()
        setupNameLabel()
        setupWeightLabel()
        setupPriceLabel()
        setupCountView()

        selectionStyle = .none

        let url = URL(string: item.image)
        foodImageView.kf.setImage(with: url)

        contentView.backgroundColor = .clear
        backgroundColor = .clear

        nameLabel.text = item.name

        weightLabel.text = item.weight
        weightLabelConstraint?.constant = weightLabel.intrinsicContentSize.width

        priceLabel.text = item.price
        priceLabelConstraint?.constant = priceLabel.intrinsicContentSize.width

        countView.count = item.quantity
    }

    private func setupCountView() {

        contentView.addSubview(countView.prepareForAutoLayout())

        countView.heightAnchor ~= 40
        countView.widthAnchor ~= 110
        countView.centerXAnchor ~= nameLabel.centerXAnchor - 10
        countView.centerYAnchor ~= priceLabel.centerYAnchor

        countView.setup()

        countView.delegate = self
    }

    private func setupBackView() {

        contentView.addSubview(backView.prepareForAutoLayout())

        backView.pinEdgesToSuperviewEdges(top: inset, left: inset * 2, right: inset * 2, bottom: inset)
    }

    private func setupFoodImageView() {

        backView.addSubview(foodImageView.prepareForAutoLayout())

        foodImageView.leadingAnchor ~= backView.leadingAnchor + inset
        foodImageView.bottomAnchor ~= backView.bottomAnchor - inset
        foodImageView.topAnchor ~= backView.topAnchor + inset
        foodImageView.widthAnchor ~= foodImageView.heightAnchor
    }

    private func setupNameLabel() {

        backView.addSubview(nameLabel.prepareForAutoLayout())

        nameLabel.leadingAnchor ~= foodImageView.trailingAnchor + 15
        nameLabel.trailingAnchor ~= backView.trailingAnchor - 9
        nameLabel.topAnchor ~= backView.topAnchor + 11
    }

    private func setupWeightLabel() {

        backView.addSubview(weightLabel.prepareForAutoLayout())

        weightLabel.leadingAnchor ~= foodImageView.trailingAnchor + 15
        weightLabel.bottomAnchor ~= backView.bottomAnchor - inset

        weightLabelConstraint = weightLabel.widthAnchor ~= 40
    }

    private func setupPriceLabel() {

        backView.addSubview(priceLabel.prepareForAutoLayout())

        priceLabel.trailingAnchor ~= backView.trailingAnchor - 9
        priceLabel.bottomAnchor ~= backView.bottomAnchor - inset

        priceLabelConstraint = priceLabel.widthAnchor ~= 50
    }
}

extension CartCell: ProductCountViewDelegate {

    func plusButtonTapped() {

        guard let item = item else {

            return
        }

        delegate?.plusButtonTapped(item: item)
    }

    func minusButtonTapped() {

        guard let item = item else {

            return
        }

        delegate?.minusButtonTapped(item: item)
    }
}
