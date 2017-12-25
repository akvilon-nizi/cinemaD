//
//  StubsView.swift
//  cinema
//
//  Created by iOS on 25.12.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

class StubsView: UIView {

    fileprivate let topLabel = UILabel()

    fileprivate let contentView = UIView()

    fileprivate let imageView = UIImageView()

    required init(coder _: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init(_ isCenter: Bool = false) {
        super.init(frame: .zero)

        addSubview(contentView.prepareForAutoLayout())
        contentView.leadingAnchor ~= leadingAnchor
        contentView.trailingAnchor ~= trailingAnchor
        contentView.topAnchor ~= topAnchor
        contentView.bottomAnchor ~= bottomAnchor

        contentView.addSubview(topLabel.prepareForAutoLayout())
        topLabel.centerXAnchor ~= contentView.centerXAnchor
        topLabel.widthAnchor ~= contentView.widthAnchor
        topLabel.topAnchor ~= topAnchor
        topLabel.numberOfLines = 0

        topLabel.textAlignment = .center
        topLabel.font = UIFont.cnmFuturaLight(size: 16)
        topLabel.textColor = UIColor.setColorGray(white: 45)
        topLabel.text = L10n.stubsTitleText

        contentView.addSubview(imageView.prepareForAutoLayout())
        imageView.widthAnchor ~= 181
        imageView.heightAnchor ~= 264
        imageView.topAnchor ~= topLabel.bottomAnchor + 38
        imageView.centerXAnchor ~= contentView.centerXAnchor
        imageView.bottomAnchor ~= contentView.bottomAnchor

        imageView.image = Asset.Cinema.blankSplash.image
    }
}
