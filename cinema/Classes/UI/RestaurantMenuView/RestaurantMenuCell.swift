//
//  RestaurantMenuCell.swift
//  foodle
//
//  Created by incetro on 09/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - RestaurantMenuCell

class RestaurantMenuCell: UITableViewCell {

    private let backView = ShadowView(frame: .zero)
    private let itemImageView = UIImageView(frame: .zero)
    private let arrowImageView = UIImageView(frame: .zero)
    private let itemNameLabel = UILabel(frame: .zero)

    func setData(_ item: RestaurantMenuItem) {

        itemNameLabel.text = item.name
        itemImageView.image = item.image
    }

    override func layoutSubviews() {

        super.layoutSubviews()

        selectionStyle = .none
        backgroundColor = .clear

        contentView.addSubview(backView)
        contentView.backgroundColor = .clear

        backView.shadowOpacity = 0.25
        backView.backgroundColor = .white
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4).isActive = true
        backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4).isActive = true

        backView.addSubview(itemImageView)

        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.backgroundColor = .black
        itemImageView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 14).isActive = true
        itemImageView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 10).isActive = true
        itemImageView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -10).isActive = true
        itemImageView.widthAnchor.constraint(equalTo: itemImageView.heightAnchor).isActive = true

        backView.addSubview(arrowImageView)

        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -14).isActive = true
        arrowImageView.centerYAnchor.constraint(equalTo: backView.centerYAnchor).isActive = true

        let arrowImage = Asset.Restaurant.restaurantMenuArrow.image

        let templateImage = arrowImage.withRenderingMode(.alwaysTemplate)
        arrowImageView.image = templateImage
        arrowImageView.tintColor = UIColor.fdlPinkishGrey

        backView.addSubview(itemNameLabel)

        itemNameLabel.font = UIFont.fdlSystemRegular(size: 15)
        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        itemNameLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 18).isActive = true
        itemNameLabel.centerYAnchor.constraint(equalTo: backView.centerYAnchor).isActive = true
    }
}
