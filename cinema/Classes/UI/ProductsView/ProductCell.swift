//
//  ProductCell.swift
//  foodle
//
//  Created by incetro on 10/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - ProductCountViewDelegate

protocol ProductCellDelegate: class {

    func incrementButtonTapped(product: ProductCellObject)

    func decrementButtonTapped(product: ProductCellObject)

    func addButtonTapped(product: ProductCellObject)
}

// MARK: - ProductCell

class ProductCell: UICollectionViewCell {

    weak var delegate: ProductCellDelegate? {

        didSet {

            addView.delegate = delegate == nil ? nil : self
        }
    }

    static let reuseIdentifier = "ProductCell"

    private let backView = ShadowView()
    private let nameLabel = UILabel(frame: .zero)
    private let addButton = UIButton(frame: .zero)
    private let priceLabel = UILabel(frame: .zero)
    private let weightLabel = UILabel(frame: .zero)
    private let mealImageView = UIImageView(frame: .zero)

    private let addView = ProductCountView(frame: .zero)

    fileprivate var product: ProductCellObject?

    func setData(_ product: ProductCellObject) {

        weightLabel.text = product.weight
        priceLabel.text = product.price
        nameLabel.text = product.name
        addView.count = product.quantityInCart

        addButton.isHidden = product.quantityInCart > 0
        addView.isHidden = !addButton.isHidden

        let url = URL(string: product.image)
        mealImageView.kf.setImage(with: url)

        self.product = product
    }

    override init(frame: CGRect) {

        super.init(frame: frame)

        addSubview(backView)

        backView.backgroundColor = .white
        backView.translatesAutoresizingMaskIntoConstraints = false

        backView.shadowOpacity = 0.4

        backView.pinEdgesToSuperviewEdges(withOffset: 0)

        setupImageView()
        setupAddButton()
        setupPriceLabel()
        setupWeightLabel()
        setupNameLabel()
        setupAddView()

        layer.cornerRadius = 5
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupAddView() {

        addSubview(addView)

        addView.translatesAutoresizingMaskIntoConstraints = false
        addView.pin(to: addButton)
        addView.isHidden = true

        addView.setup()
    }

    private func setupNameLabel() {

        let centerView = UIView(frame: .zero)

        backView.addSubview(centerView)

        centerView.translatesAutoresizingMaskIntoConstraints = false
        centerView.pinToSuperview([.left, .right])
        centerView.topAnchor.constraint(equalTo: mealImageView.bottomAnchor).isActive = true
        centerView.bottomAnchor.constraint(equalTo: priceLabel.topAnchor).isActive = true

        centerView.addSubview(nameLabel)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerYAnchor.constraint(equalTo: centerView.centerYAnchor).isActive = true
        nameLabel.pinEdgesToSuperviewEdges(top: 3, left: 9, right: 9, bottom: 3)

        nameLabel.font = UIFont.fdlSystemRegular(size: 13)
        nameLabel.textColor = UIColor.fdlWarmGrey
        nameLabel.numberOfLines = 0
    }

    private func setupWeightLabel() {

        backView.addSubview(weightLabel)

        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        weightLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10).isActive = true
        weightLabel.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -7).isActive = true
        weightLabel.textColor = UIColor.fdlGreyishBrown
        weightLabel.font = UIFont.fdlSystemRegular(size: 12)
    }

    private func setupPriceLabel() {

        backView.addSubview(priceLabel)

        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 9).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -6).isActive = true
        priceLabel.font = UIFont.fdlGothamProMedium(size: 17)
        priceLabel.textColor = UIColor.fdlGreyishBrown
    }

    private func setupAddButton() {

        backView.addSubview(addButton)

        addButton.backgroundColor = UIColor.fdlPaleGrey
        addButton.setTitle(L10n.restaurantFavoriteButtonTitle, for: .normal)
        addButton.titleLabel?.font = UIFont.fdlSystemRegular(size: 13)
        addButton.setTitleColor(UIColor.fdlGreyishBrown, for: .normal)

        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: [.bottomLeft, .bottomRight],
                                    cornerRadii: CGSize(width: 5, height: 5))

        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath

        addButton.layer.mask = shape
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.heightAnchor.constraint(equalToConstant: 38).isActive = true
        addButton.pinEdgesToSuperviewEdges(excluding: .top)

        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
    }

    func didTapAddButton() {

        guard let product = product else {

            return
        }

        addButton.isHidden = true

        addView.isHidden = false
        addView.startSpinning()

        delegate?.addButtonTapped(product: product)
    }

    private func setupImageView() {

        backView.addSubview(mealImageView)

        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: [.topLeft, .topRight],
                                    cornerRadii: CGSize(width: 5, height: 5))

        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        mealImageView.layer.mask = shape

        mealImageView.translatesAutoresizingMaskIntoConstraints = false
        mealImageView.pinEdgesToSuperviewEdges(excluding: .bottom)
        mealImageView.heightAnchor.constraint(equalTo: mealImageView.widthAnchor, multiplier: 0.575).isActive = true
    }
}

// MARK: - ProductCountViewDelegate

extension ProductCell: ProductCountViewDelegate {

    func plusButtonTapped() {

        guard let product = product else {

            return
        }

        delegate?.incrementButtonTapped(product: product)
    }

    func minusButtonTapped() {

        guard let product = product else {

            return
        }

        delegate?.decrementButtonTapped(product: product)
    }
}
