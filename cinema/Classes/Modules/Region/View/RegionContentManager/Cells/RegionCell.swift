//
//  RegionCell.swift
//  foodle
//
//  Created by incetro on 24/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - RegionCell

class RegionCell: UITableViewCell {

    private let backView: ShadowView = {

        let backView = ShadowView()

        backView.cornerRadius = 0
        backView.shadowOpacity = 0
        backView.layer.shadowRadius = 0
        backView.backgroundColor = UIColor(white: 247.0 / 255.0, alpha: 1)

        return backView
    }()

    private let iconImageView: UIImageView = {

        let iconImageView = UIImageView()

        return iconImageView
    }()

    private let checkImageView: UIImageView = {

        let checkImageView = UIImageView(image: Asset.Region.regionCheckImage.image)

        checkImageView.isHidden = true

        return checkImageView
    }()

    private let nameLabel: UILabel = {

        let nameLabel = UILabel()

        nameLabel.textColor = .fdlGreyishBrown
        nameLabel.font = UIFont.fdlSystemRegular(size: 15)

        return nameLabel
    }()

    func setData(region: Region) {

        clipsToBounds = false
        backgroundColor = .clear
        selectionStyle = .none

        setupBackView()
        setupIconImageView()
        setupNameLabel()
        setupCheckImageView()

        nameLabel.text = region.name
        iconImageView.kf.setImage(with: URL(string: region.icon))
    }

    private func setupBackView() {

        addSubview(backView.prepareForAutoLayout())

        backView.topAnchor ~= topAnchor + 5
        backView.bottomAnchor ~= bottomAnchor - 5
        backView.leadingAnchor ~= leadingAnchor + 10
        backView.trailingAnchor ~= trailingAnchor - 10
    }

    private func setupIconImageView() {

        backView.addSubview(iconImageView.prepareForAutoLayout())

        iconImageView.leadingAnchor ~= backView.leadingAnchor + 9
        iconImageView.bottomAnchor ~= backView.bottomAnchor - 9
        iconImageView.topAnchor ~= backView.topAnchor + 9
        iconImageView.heightAnchor ~= iconImageView.widthAnchor
    }

    private func setupCheckImageView() {

        backView.addSubview(checkImageView.prepareForAutoLayout())

        checkImageView.trailingAnchor ~= backView.trailingAnchor - 15
        checkImageView.centerYAnchor ~= backView.centerYAnchor
        checkImageView.widthAnchor ~= 17
        checkImageView.heightAnchor ~= 13
    }

    private func setupNameLabel() {

        backView.addSubview(nameLabel.prepareForAutoLayout())

        nameLabel.centerYAnchor ~= iconImageView.centerYAnchor
        nameLabel.leadingAnchor ~= iconImageView.trailingAnchor + 18
    }

    override func setSelected(_ selected: Bool, animated: Bool) {

        super.setSelected(selected, animated: animated)

        checkImageView.isHidden = !selected

        if selected {

            backView.cornerRadius = 5
            backView.shadowOpacity = 0.25
            backView.layer.shadowRadius = 10
            backView.backgroundColor = .white

        } else {

            backView.cornerRadius = 0
            backView.shadowOpacity = 0
            backView.layer.shadowRadius = 0
            backView.backgroundColor = UIColor(white: 247.0 / 255.0, alpha: 1)
        }
    }
}
