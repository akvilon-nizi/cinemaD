//
//  SlideView.swift
//  foodle
//
//  Created by Mac on 31.08.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

struct SlideStruct {
    let title: String
    let descriprion: String

    init(image: UIImage, title: String, descriprion: String) {
        self.title = title
        self.descriprion = descriprion
    }
}

class SlideView: UIView {

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
            titleLabel.text = slideInfo?.title
            descriptionLabel.text = slideInfo?.descriprion
        }
    }

    override init(frame: CGRect) {

        super.init(frame: frame)

        addSubview(titleLabel.prepareForAutoLayout())

        titleLabel.leadingAnchor ~= leadingAnchor + 40
        titleLabel.trailingAnchor ~= trailingAnchor - 40
        titleLabel.topAnchor ~= topAnchor + 111

        addSubview(descriptionLabel.prepareForAutoLayout())

        descriptionLabel.leadingAnchor ~= leadingAnchor + 40
        descriptionLabel.trailingAnchor ~= trailingAnchor - 40
        descriptionLabel.topAnchor ~= titleLabel.bottomAnchor + 24

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
