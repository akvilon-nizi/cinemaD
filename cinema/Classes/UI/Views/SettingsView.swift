//
//  SettingsView.swift
//  cinema
//
//  Created by iOS on 24.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

class SettingsView: UIView {

    var text: String? {
        didSet {
            nameSettingLabel.text = text
        }
    }

    private let nameSettingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFuturaLight(size: 16)
        label.textColor = UIColor.cnm3a3a3a
        label.numberOfLines = 1
        return label
    }()
    private let selectImage: UIImageView = {
        let imageView = UIImageView()
        imageView.heightAnchor ~= 21
        imageView.widthAnchor ~= 21
        return imageView
    }()

    required init(coder _: NSCoder) {
        fatalError("NSCoding not supported")
    }

    var didSelect: Bool = false {
        didSet {
            if didSelect {
                selectImage.image = Asset.Kinobase.check28.image
            } else {
                selectImage.image = Asset.Kinobase.cicle.image
            }
        }
    }

    init() {
        super.init(frame: .zero)

        heightAnchor ~= 65

        addSubview(nameSettingLabel.prepareForAutoLayout())
        nameSettingLabel.leadingAnchor ~= leadingAnchor + 54
        nameSettingLabel.centerYAnchor ~= centerYAnchor

        addSubview(selectImage.prepareForAutoLayout())
        selectImage.centerYAnchor ~= centerYAnchor
        selectImage.trailingAnchor ~= trailingAnchor - 60

        let separatorView = UIView()
        separatorView.backgroundColor = .cnmDadada
        addSubview(separatorView.prepareForAutoLayout())
        separatorView.bottomAnchor ~= bottomAnchor
        separatorView.trailingAnchor ~= trailingAnchor - 24
        separatorView.leadingAnchor ~= leadingAnchor + 24
        separatorView.heightAnchor ~= 1
    }
}
