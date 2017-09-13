//
//  RegionHeaderView.swift
//  foodle
//
//  Created by incetro on 24/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - RegionHeaderView

class RegionHeaderView: UIView {

    private let imageView: UIImageView = {

        let imageView = UIImageView(image: Asset.Region.regionMainImage.image)

        return imageView
    }()

    private let titleLabel: UILabel = {

        let titleLabel = UILabel()

        titleLabel.textColor = .fdlGreyishBrown
        titleLabel.font = UIFont.fdlGothamProMedium(size: 20)
        titleLabel.textAlignment = .center
        titleLabel.text = L10n.regionMainTitle

        return titleLabel
    }()

    private let descriptionLabel: UILabel = {

        let descriptionLabel = UILabel()

        descriptionLabel.textColor = .fdlWarmGrey
        descriptionLabel.font = UIFont.fdlSystemRegular(size: 15)
        descriptionLabel.textAlignment = .center
        descriptionLabel.text = L10n.regionMainDescription
        descriptionLabel.numberOfLines = 0

        return descriptionLabel
    }()

    override init(frame: CGRect) {

        super.init(frame: frame)

        addSubview(imageView.prepareForAutoLayout())

        imageView.centerXAnchor ~= centerXAnchor
        imageView.topAnchor ~= topAnchor + 10
        imageView.widthAnchor ~= 92
        imageView.heightAnchor ~= imageView.widthAnchor

        addSubview(titleLabel.prepareForAutoLayout())

        titleLabel.topAnchor ~= imageView.bottomAnchor + 30
        titleLabel.centerXAnchor ~= centerXAnchor

        addSubview(descriptionLabel.prepareForAutoLayout())

        descriptionLabel.topAnchor ~= titleLabel.bottomAnchor + 13
        descriptionLabel.centerXAnchor ~= centerXAnchor
        descriptionLabel.widthAnchor ~= 220
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
