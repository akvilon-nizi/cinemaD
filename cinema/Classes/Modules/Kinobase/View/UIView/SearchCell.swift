//
//  SearchView.swift
//  cinema
//
//  Created by Mac on 29.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - WatchedView

class SearchCell: UIView {

    let button: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.cnmMainOrange.cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 11
        button.heightAnchor ~= 22
        button.widthAnchor ~= 22
        let imageView = UIImageView()
        return button
    }()

   let titleLabel: UILabel = {

        let titleLabel = UILabel()

        titleLabel.text = L10n.slide1ButtonText
        titleLabel.font = UIFont.cnmFutura(size: 16)
        titleLabel.textColor = UIColor.cnmGreyDark

        return titleLabel
    }()

    override init(frame: CGRect) {

        super.init(frame: frame)

        heightAnchor ~= 39
        addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.leadingAnchor ~= leadingAnchor + 58
        titleLabel.centerYAnchor ~= centerYAnchor

        addSubview(button.prepareForAutoLayout())
        button.centerYAnchor ~= centerYAnchor
        button.trailingAnchor ~= trailingAnchor - 53

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
