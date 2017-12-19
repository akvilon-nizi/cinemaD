//
//  NewFriendsCell.swift
//  cinema
//
//  Created by iOS on 19.12.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit
import Kingfisher

class NewFriendsCell: UICollectionViewCell {
    fileprivate let posterView = UIImageView()
    fileprivate let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFuturaBold(size: 14)
        label.numberOfLines = 2
        label.textColor = UIColor.cnmBlue
        label.widthAnchor ~= 88
        label.lineBreakMode = .byWordWrapping
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

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(posterView.prepareForAutoLayout())
        posterView.backgroundColor = UIColor.lightGray
        posterView.topAnchor ~= topAnchor + 10
        posterView.centerXAnchor ~= centerXAnchor
        posterView.layer.cornerRadius = 28.0
        posterView.layer.masksToBounds = true
        posterView.heightAnchor ~= 56
        posterView.contentMode = .scaleAspectFill
        posterView.widthAnchor ~= 56

        addSubview(nameLabel.prepareForAutoLayout())
        nameLabel.topAnchor ~= posterView.bottomAnchor + 7
        nameLabel.centerXAnchor ~= centerXAnchor

    }

    static var reuseIdentifier: String {
        return "NewFriendsCell"
    }
}
