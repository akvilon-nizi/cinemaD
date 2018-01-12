//
//  SlideView.swift
//  cinema
//
//  Created by Mac on 31.08.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

struct SlideStruct {
    let title: String
    let descriprion: String
    let mainView: UIView

    init(image: UIImage, title: String, descriprion: String, mainView: UIView) {
        self.title = title
        self.descriprion = descriprion
        self.mainView = mainView
    }
}

class SlideView: UIView {

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.fdlGreyishBrown
        titleLabel.font = UIFont.cnmFuturaMedium(size: 17)
        titleLabel.textAlignment = .center
        return titleLabel
    } ()
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.textColor = UIColor.fdlGreyishBrown
        descriptionLabel.font = UIFont.cnmFutura(size: 14)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    } ()

    private let mainView: UIView = UIView()

    var slideInfo: SlideStruct? {
        didSet {
            titleLabel.text = slideInfo?.title
            descriptionLabel.text = slideInfo?.descriprion
            if let view = slideInfo?.mainView {
                mainView.addSubview(view.prepareForAutoLayout())
                view.pinEdgesToSuperviewEdges()
            }
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

        addSubview(mainView.prepareForAutoLayout())

        mainView.leadingAnchor ~= leadingAnchor + 40
        mainView.trailingAnchor ~= trailingAnchor - 40
        mainView.topAnchor ~= descriptionLabel.bottomAnchor
        mainView.heightAnchor ~= 293

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
