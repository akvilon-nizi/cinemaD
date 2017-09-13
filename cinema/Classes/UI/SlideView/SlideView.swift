//
//  SlideView.swift
//  foodle
//
//  Created by Mac on 31.08.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

struct SlideStruct {
    let image: UIImage
    let title: String
    let descriprion: String

    init(image: UIImage, title: String, descriprion: String) {
        self.image = image
        self.title = title
        self.descriprion = descriprion
    }
}

class SlideView: UIView {

    private let mainImage: UIImageView = {
        let mainImage = UIImageView()
        mainImage.contentMode = .scaleToFill
        return mainImage
    } ()

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.fdlGreyishBrown
        titleLabel.font = UIFont.fdlGothamProMedium(size: 20)
        titleLabel.textAlignment = .center
        return titleLabel
    } ()
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.textColor = UIColor.fdlGreyishBrown
        descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    } ()

    var slideInfo: SlideStruct? {
        didSet {
            mainImage.image = slideInfo?.image
            titleLabel.text = slideInfo?.title
            descriptionLabel.text = slideInfo?.descriprion
        }
    }

    override init(frame: CGRect) {

        super.init(frame: frame)
        addSubview(mainImage.prepareForAutoLayout())

        mainImage.centerXAnchor ~= centerXAnchor
        mainImage.topAnchor ~= topAnchor + 25

        addSubview(titleLabel.prepareForAutoLayout())

        titleLabel.leadingAnchor ~= leadingAnchor + 40
        titleLabel.trailingAnchor ~= trailingAnchor - 40
        titleLabel.topAnchor ~= mainImage.bottomAnchor + 25

        addSubview(descriptionLabel.prepareForAutoLayout())

        descriptionLabel.leadingAnchor ~= leadingAnchor + 40
        descriptionLabel.trailingAnchor ~= trailingAnchor - 40
        descriptionLabel.topAnchor ~= titleLabel.bottomAnchor + 13

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
