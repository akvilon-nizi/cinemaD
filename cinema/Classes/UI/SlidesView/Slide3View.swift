//
//  Slide3View.swift
//  cinema
//
//  Created by Mac on 14.09.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - Slide3View

class Slide3View: UIView {

    private let contentView = UIView()

    private let titleLabel: UILabel = {

        let titleLabel = UILabel()

        titleLabel.text = L10n.slide3LabelTitleText
        titleLabel.font = UIFont.fdlGothamProMedium(size: 18)
        titleLabel.textColor = UIColor.cnmGreyDark

        return titleLabel
    }()

    private let nameLabel: UILabel = {

        let nameLabel = UILabel()

        nameLabel.text = ""
        nameLabel.font = UIFont.cnmFutura(size: 14)
        nameLabel.textColor = UIColor.cnmGreyDark

        return nameLabel
    }()

    private let descriptionLabel: UILabel = {

        let descriptionLabel = UILabel()

        descriptionLabel.font = UIFont.fdlSystemRegular(size: 18)
        descriptionLabel.text = L10n.slide3LabelDescriptionText
        descriptionLabel.textColor = UIColor.cnmBlueLight

        return descriptionLabel
    }()

    private let imagesArray: [UIImageView] = [
        UIImageView(image: Asset.Cinema.Slides.slide3Image1.image).setSize(width: 15, height: 20),
        UIImageView(image: Asset.Cinema.Slides.slide3Image2.image).setSize(width: 33, height: 37),
        UIImageView(image: Asset.Cinema.Slides.slide3Image3.image).setSize(width: 39, height: 67),
        UIImageView(image: Asset.Cinema.Slides.slide3Image4.image).setSize(width: 33, height: 37),
        UIImageView(image: Asset.Cinema.Slides.slide3Image5.image).setSize(width: 15, height: 20)
    ]

    override init(frame: CGRect) {

        super.init(frame: frame)

        addSubview(contentView.prepareForAutoLayout())
        contentView.centerXAnchor ~= centerXAnchor
        contentView.centerYAnchor ~= centerYAnchor

        contentView.addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.centerXAnchor ~= contentView.centerXAnchor
        titleLabel.topAnchor ~= contentView.topAnchor

        contentView.addSubview(nameLabel.prepareForAutoLayout())
        nameLabel.centerXAnchor ~= contentView.centerXAnchor
        nameLabel.topAnchor ~= titleLabel.bottomAnchor + 10

        let stackView = createStackView(.horizontal, .center, .fillProportionally, 32, with: imagesArray)
        contentView.addSubview(stackView.prepareForAutoLayout())
        stackView.centerXAnchor ~= contentView.centerXAnchor
        stackView.topAnchor ~= nameLabel.bottomAnchor + 17

        contentView.addSubview(descriptionLabel.prepareForAutoLayout())
        descriptionLabel.centerXAnchor ~= contentView.centerXAnchor
        descriptionLabel.topAnchor ~= stackView.bottomAnchor + 23
        descriptionLabel.bottomAnchor ~= contentView.bottomAnchor

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIImageView {
    func setSize(width: CGFloat, height: CGFloat) -> UIImageView {
        self.contentMode = .scaleToFill
        self.widthAnchor ~= width
        self.heightAnchor ~= height
        return self
    }
}
