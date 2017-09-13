//
// Created by Xander on 02.09.17.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class AnnotationCardView: UIView, Swipeable {

    private weak var output: RestaurantsDisplayItemOutput?

    private(set) var coverView = UIView()

    private let contentView = UIView()
    private let nameLabel = UILabel()
    private let addressLabel = UILabel()
    private let ratingStar = RatingStar()
    private let checkButton = UIButton()
    private let tableButton = ButtonTableType.check.button
    private let previewImageView = ImageView()

    private let hIndent: CGFloat = 15

    required init(coder _: NSCoder) {
        fatalError("NSCoder not supported")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapOnCard))

        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
        contentView.addGestureRecognizer(tap)
        addSubview(contentView)

        nameLabel.font = .fdlGothamProMedium(size: 20)
        nameLabel.textColor = .fdlGreyishBrown
        contentView.addSubview(nameLabel)

        addressLabel.font = .fdlSystemRegular(size: 15)
        addressLabel.textColor = .fdlGreyishBrown
        contentView.addSubview(addressLabel)

        contentView.addSubview(ratingStar)

        tableButton.addTarget(self, action: #selector(handleTableButtonPressed), for: .touchUpInside)
        contentView.addSubview(tableButton)

        previewImageView.backgroundColor = .lightGray
        contentView.addSubview(previewImageView)

        coverView.isHidden = true
        coverView.backgroundColor = .fdlNavy
        contentView.addSubview(coverView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = bounds
        coverView.frame = bounds

        let width = bounds.width
        let height = bounds.height

        nameLabel.frame = CGRect(
            x: hIndent,
            y: 15,
            width: width - hIndent * 2 - height,
            height: 24
        )

        addressLabel.frame = CGRect(
            x: hIndent,
            y: nameLabel.frame.maxY + 6,
            width: width - hIndent * 2 - height,
            height: 18
        )

        ratingStar.frame = CGRect(
            x: hIndent,
            y: height - 12 - ratingStar.frame.height,
            width: ratingStar.frame.width,
            height: ratingStar.frame.height
        )

        tableButton.frame = CGRect(
            x: width - height - hIndent - 118,
            y: height - 12 - 24,
            width: 118,
            height: 24
        )

        previewImageView.frame = CGRect(
            x: width - height,
            y: 0,
            width: height,
            height: height
        )

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.6
        layer.shadowRadius = 5
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 5).cgPath
    }

    func update(with item: RestaurantsDisplayItem) {
        if let restaurantItem = item as? RestaurantsDisplayItemOutput {
            output = restaurantItem
        }

        nameLabel.text = item.name
        addressLabel.text = item.address
        ratingStar.text = item.rating
        ratingStar.sizeToFit()
        previewImageView.setImage(with: item.image)
    }

    // MARK: - Actions

    func handleTapOnCard() {
        output?.needOpenRestaurant()
    }

    func handleTableButtonPressed() {
        output?.needCheckTableInRestaurant()
    }

    // MARK: - Private inner class

    private class RatingStar: UIView {

        var text: String? {
            didSet {
                ratingLabel.text = text
                ratingLabel.sizeToFit()

                guard let rating = text, !rating.isEmpty else {
                    isHidden = true
                    return
                }
                isHidden = false
            }
        }

        private let ratingLabel = UILabel()
        private let starImageView = UIImageView(image: Asset.RatingStar.ratingStarSmall.image)

        required init(coder _: NSCoder) {
            fatalError("NSCoder not supported")
        }

        override init(frame: CGRect) {
            super.init(frame: frame)

            ratingLabel.font = .fdlSystemMedium(size: 15)
            ratingLabel.textColor = .fdlGreyishBrown
            addSubview(ratingLabel)

            addSubview(starImageView)
        }

        override func layoutSubviews() {
            super.layoutSubviews()

            ratingLabel.frame = CGRect(
                x: 0,
                y: 0,
                width: ratingLabel.frame.width,
                height: 16
            )

            starImageView.frame = CGRect(
                x: ratingLabel.frame.maxX + 1,
                y: 0,
                width: 15,
                height: 14
            )
        }

        override func sizeThatFits(_ size: CGSize) -> CGSize {
            return CGSize(width: starImageView.frame.maxX, height: 16)
        }
    }
}
