//
//  RolesCell.swift
//  cinema
//
//  Created by User on 19.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit
import Kingfisher

class RolesCell: UICollectionViewCell {
    fileprivate let posterView = UIImageView()
    fileprivate let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFuturaBold(size: 13)
        label.numberOfLines = 1
        label.textColor = UIColor.cnm3a3a3a
        label.widthAnchor ~= 88
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    fileprivate let roleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFuturaLight(size: 12)
        label.numberOfLines = 0
        label.textColor = UIColor.cnmAfafaf
        label.widthAnchor ~= 58
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    var linkUrlImage: String = "" {
        didSet {
            posterView.kf.indicatorType = .activity
            posterView.kf.setImage(with: URL(string: linkUrlImage))
            if linkUrlImage.isEmpty {
                posterView.image = nil
            }
        }
    }

    var name: String = "" {
        didSet {
            nameLabel.text = name
        }
    }

    var role: String = "" {
        didSet {
            roleLabel.text = role
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(posterView.prepareForAutoLayout())
        posterView.backgroundColor = UIColor.lightGray
        posterView.topAnchor ~= topAnchor
        posterView.centerXAnchor ~= centerXAnchor
        posterView.layer.cornerRadius = 28.0
        posterView.layer.masksToBounds = true
        posterView.heightAnchor ~= 56
        posterView.contentMode = .scaleAspectFill
        posterView.widthAnchor ~= 56

        addSubview(nameLabel.prepareForAutoLayout())
        nameLabel.topAnchor ~= posterView.bottomAnchor + 7
        nameLabel.centerXAnchor ~= centerXAnchor

        addSubview(roleLabel.prepareForAutoLayout())
        roleLabel.topAnchor ~= nameLabel.bottomAnchor + 5
        roleLabel.centerXAnchor ~= centerXAnchor

    }

    static var reuseIdentifier: String {
        return "RolesCell"
    }
}
