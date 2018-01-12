//
//  Slide1View.swift
//  cinema
//
//  Created by Mac on 01.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - Slide3View

class Slide1View: UIView {

    private let contentView = UIView()

    private let titleLabel: UILabel = {

        let titleLabel = UILabel()

        titleLabel.text = L10n.slide1ButtonText
        titleLabel.font = UIFont.fdlGothamProMedium(size: 9)
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = UIColor.cnmMainOrange
        titleLabel.layer.cornerRadius = 3.0
        titleLabel.layer.masksToBounds = true

        return titleLabel
    }()

    override init(frame: CGRect) {

        super.init(frame: frame)

        addSubview(contentView.prepareForAutoLayout())
        contentView.centerXAnchor ~= centerXAnchor
        contentView.centerYAnchor ~= centerYAnchor

        let imageView = UIImageView(image: Asset.Cinema.Slides.slide1Image.image).setSize(width: 144, height: 191)
        contentView.addSubview(imageView.prepareForAutoLayout())
        imageView.centerXAnchor ~= contentView.centerXAnchor - 4
        imageView.topAnchor ~= contentView.topAnchor - 30

        contentView.addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.centerXAnchor ~= contentView.centerXAnchor
        titleLabel.topAnchor ~= imageView.bottomAnchor + 10
        titleLabel.heightAnchor ~= 27
        titleLabel.widthAnchor ~= 100
        titleLabel.bottomAnchor ~= contentView.bottomAnchor

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
