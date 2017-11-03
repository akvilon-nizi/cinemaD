//
//  Slide2View.swift
//  cinema
//
//  Created by Mac on 01.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - Slide3View

class Slide2View: UIView {

    private let contentView = UIView()

    private let titleLabel: UILabel = {

        let titleLabel = UILabel()

        titleLabel.text = L10n.slide2ButtonText
        titleLabel.font = UIFont.fdlGothamProMedium(size: 7)
        titleLabel.textColor = UIColor.cnmMainOrange
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = UIColor.white
        titleLabel.layer.borderWidth = 1.0
        titleLabel.layer.borderColor = UIColor.cnmMainOrange.cgColor
        titleLabel.layer.cornerRadius = 3.0
        titleLabel.layer.masksToBounds = true

        return titleLabel
    }()

    override init(frame: CGRect) {

        super.init(frame: frame)

        addSubview(contentView.prepareForAutoLayout())
        contentView.centerXAnchor ~= centerXAnchor
        contentView.centerYAnchor ~= centerYAnchor

        let imageView = UIImageView(image:Asset.Cinema.Slides.slide2Image.image).setSize(width: 124, height: 178)
        contentView.addSubview(imageView.prepareForAutoLayout())
        imageView.centerXAnchor ~= contentView.centerXAnchor - 4
        imageView.topAnchor ~= contentView.topAnchor

        let playImage = UIImageView(image:Asset.Cinema.Slides.slide2Play.image).setSize(width: 29, height: 29)
        imageView.addSubview(playImage.prepareForAutoLayout())
        playImage.centerXAnchor ~= imageView.centerXAnchor
        playImage.centerYAnchor ~= imageView.centerYAnchor

        contentView.addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.centerXAnchor ~= contentView.centerXAnchor
        titleLabel.topAnchor ~= imageView.bottomAnchor + 25
        titleLabel.heightAnchor ~= 27
        titleLabel.widthAnchor ~= 100
        titleLabel.bottomAnchor ~= contentView.bottomAnchor

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
