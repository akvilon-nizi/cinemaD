//
//  RestaurantInfoBottomView.swift
//  foodle
//
//  Created by incetro on 08/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - RestaurantInfoBottomView

class RestaurantInfoBottomView: UIView {

    private static let offset: CGFloat = 10

    private let timeView = ShadowView(frame: .zero)
    private let priceView = ShadowView(frame: .zero)
    private let ratingview = ShadowView(frame: .zero)

    private let ratingLabel = UILabel(frame: .zero)
    private let starImageView = UIImageView(frame: .zero)
    private let ratingDescriptionLabel = UILabel(frame: .zero)

    private let openingTimeLabel = UILabel(frame: .zero)
    private let timeDescriptionLabel = UILabel(frame: .zero)

    private let priceLabel = UILabel(frame: .zero)
    private let priceDescriptionLabel = UILabel(frame: .zero)

    func configure(withRating rating: String, remainingTime: String, openingTime: String, price: String) {

        priceLabel.text = price
        ratingLabel.text = rating
        openingTimeLabel.text = openingTime
        timeDescriptionLabel.text = remainingTime
    }

    func setup(inView view: UIView) {

        translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(self)

        heightAnchor.constraint(equalToConstant: 71).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: RestaurantInfoBottomView.offset).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -RestaurantInfoBottomView.offset).isActive = true

        setupRatingView()
        setupTimeView()
        setupPriceView()

        [priceView, timeView, ratingview].forEach {

            $0.layer.cornerRadius = 5
            $0.backgroundColor = .white
        }

        let stackView = UIStackView(frame: .zero)

        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 7.5

        stackView.addArrangedSubview(ratingview)
        stackView.addArrangedSubview(timeView)
        stackView.addArrangedSubview(priceView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)

        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }

    private func setupTimeView() {

        timeView.addSubview(timeDescriptionLabel)

        timeDescriptionLabel.textColor = UIColor.fdlWarmGrey
        timeDescriptionLabel.font = UIFont.fdlSystemRegular(size: 10)
        timeDescriptionLabel.lineBreakMode = .byWordWrapping
        timeDescriptionLabel.numberOfLines = 0
        timeDescriptionLabel.textAlignment = .center
        timeDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        timeDescriptionLabel.bottomAnchor.constraint(equalTo: timeView.bottomAnchor, constant: -10).isActive = true
        timeDescriptionLabel.leadingAnchor.constraint(equalTo: timeView.leadingAnchor, constant: 5).isActive = true
        timeDescriptionLabel.trailingAnchor.constraint(equalTo: timeView.trailingAnchor, constant: -5).isActive = true

        timeView.addSubview(openingTimeLabel)

        openingTimeLabel.textColor = UIColor.fdlGreyishBrown
        openingTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        openingTimeLabel.textAlignment = .center
        openingTimeLabel.font = UIFont.fdlGothamProBold(size: 13)
        openingTimeLabel.topAnchor.constraint(equalTo: timeView.topAnchor, constant: 22).isActive = true
        openingTimeLabel.leadingAnchor.constraint(equalTo: timeView.leadingAnchor, constant: 5).isActive = true
        openingTimeLabel.trailingAnchor.constraint(equalTo: timeView.trailingAnchor, constant: -5).isActive = true
    }

    private func setupRatingView() {

        ratingview.addSubview(ratingDescriptionLabel)

        ratingDescriptionLabel.text = L10n.restaurantRatingTitle
        ratingDescriptionLabel.textColor = UIColor.fdlWarmGrey
        ratingDescriptionLabel.font = UIFont.fdlSystemRegular(size: 10)
        ratingDescriptionLabel.lineBreakMode = .byWordWrapping
        ratingDescriptionLabel.numberOfLines = 0
        ratingDescriptionLabel.textAlignment = .center
        ratingDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingDescriptionLabel.bottomAnchor.constraint(equalTo: ratingview.bottomAnchor, constant: -10).isActive = true
        ratingDescriptionLabel.leadingAnchor.constraint(equalTo: ratingview.leadingAnchor, constant: 1).isActive = true
        ratingDescriptionLabel.trailingAnchor.constraint(equalTo: ratingview.trailingAnchor, constant: -1).isActive = true

        ratingview.addSubview(ratingLabel)

        ratingLabel.textColor = UIColor.fdlGreyishBrown
        ratingLabel.font = UIFont.fdlGothamProBold(size: 22)
        ratingLabel.textAlignment = .right
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.trailingAnchor.constraint(equalTo: ratingview.centerXAnchor, constant: 8).isActive = true
        ratingLabel.topAnchor.constraint(equalTo: ratingview.topAnchor, constant: 15).isActive = true
        ratingLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true

        ratingview.addSubview(starImageView)

        starImageView.image = Asset.Restaurant.restaurantInfoRatingStar.image
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        starImageView.leadingAnchor.constraint(equalTo: ratingview.centerXAnchor, constant: 12).isActive = true
        starImageView.widthAnchor.constraint(equalToConstant: 18).isActive = true
        starImageView.centerYAnchor.constraint(equalTo: ratingLabel.centerYAnchor).isActive = true
    }

    private func setupPriceView() {

        priceView.addSubview(priceDescriptionLabel)

        priceDescriptionLabel.text = L10n.restaurantPriceTitle
        priceDescriptionLabel.textColor = UIColor.fdlWarmGrey
        priceDescriptionLabel.lineBreakMode = .byWordWrapping
        priceDescriptionLabel.numberOfLines = 0
        priceDescriptionLabel.font = UIFont.fdlSystemRegular(size: 10)
        priceDescriptionLabel.textAlignment = .center
        priceDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        priceDescriptionLabel.bottomAnchor.constraint(equalTo: priceView.bottomAnchor, constant: -10).isActive = true
        priceDescriptionLabel.leadingAnchor.constraint(equalTo: priceView.leadingAnchor, constant: 5).isActive = true
        priceDescriptionLabel.trailingAnchor.constraint(equalTo: priceView.trailingAnchor, constant: -5).isActive = true

        priceView.addSubview(priceLabel)

        priceLabel.textColor = UIColor.fdlGreyishBrown
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.textAlignment = .center
        priceLabel.font = UIFont.fdlGothamProBold(size: 13)
        priceLabel.topAnchor.constraint(equalTo: priceView.topAnchor, constant: 22).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: priceView.leadingAnchor, constant: 5).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: priceView.trailingAnchor, constant: -5).isActive = true
    }
}
