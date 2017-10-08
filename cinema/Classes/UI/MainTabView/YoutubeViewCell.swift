//
//  YoutubeViewCell.swift
//  cinema
//
//  Created by User on 08.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

class YoutubeViewCell: UICollectionViewCell {

    fileprivate let titleLabel = UILabel()

    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        clipsToBounds = true
        layer.cornerRadius = 3
        //layer.borderColor = UIColor.insDodgerBlue.cgColor
        layer.borderWidth = 1

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        titleLabel.font = UIFont.ubuntuRegular(size: 13)
//        titleLabel.textColor = .insDodgerBlue
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)

        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2).isActive = true
    }
}
