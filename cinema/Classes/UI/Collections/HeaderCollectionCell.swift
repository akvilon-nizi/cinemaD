//
//  HeaderCollectionCell.swift
//  cinema
//
//  Created by iOS on 13.12.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - HeaderCollectionCell

import UIKit
import Kingfisher

class HeaderCollectionCell: UICollectionViewCell {

    private let rewardImage = UIImageView()

    let windowWidth = UIWindow(frame: UIScreen.main.bounds).bounds.size.width

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFuturaMedium(size: 20)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    private let newsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFuturaLight(size: 14)
        label.textColor = UIColor.cnm3a3a3a
        label.numberOfLines = 0
        return label
    }()

    var layout: NSLayoutConstraint?

    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    var linkUrlImage: String = "" {
        didSet {
            rewardImage.kf.indicatorType = .activity
            rewardImage.kf.setImage(with: URL(string: linkUrlImage))
        }
    }

    var text: String = "" {
        didSet {
            newsLabel.text = text
        }
    }

    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(rewardImage.prepareForAutoLayout())
        rewardImage.topAnchor ~= contentView.topAnchor
        rewardImage.leadingAnchor ~= contentView.leadingAnchor
        rewardImage.trailingAnchor ~= contentView.trailingAnchor
        rewardImage.layer.masksToBounds = true
        rewardImage.widthAnchor ~= windowWidth
        rewardImage.heightAnchor ~= windowWidth / 375 * 131
        rewardImage.contentMode = .scaleAspectFill

        contentView.addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.centerXAnchor ~= rewardImage.centerXAnchor
        titleLabel.centerYAnchor ~= rewardImage.centerYAnchor
        //titleLabel.text = "wsfdasfsa"

        contentView.addSubview(newsLabel.prepareForAutoLayout())
        layout = newsLabel.topAnchor.constraint(equalTo: rewardImage.bottomAnchor)
        layout?.isActive = true
        layout?.constant = -10
        newsLabel.leadingAnchor ~= rewardImage.leadingAnchor + 35
        newsLabel.trailingAnchor ~= rewardImage.trailingAnchor - 35

        let separatorView = UIView()
        separatorView.backgroundColor = .cnmDadada
        contentView.addSubview(separatorView.prepareForAutoLayout())
        separatorView.bottomAnchor ~= contentView.bottomAnchor
        separatorView.trailingAnchor ~= contentView.trailingAnchor - 24
        separatorView.leadingAnchor ~= contentView.leadingAnchor + 24
        separatorView.heightAnchor ~= 1
        separatorView.topAnchor ~= newsLabel.bottomAnchor + 24
    }

    func setInfo(text: String, title: String, imageUrl: String) {
        linkUrlImage = imageUrl
        self.title = title
        self.text = text
        if text != "" {
            layout?.constant = 35
            UIView.animate(withDuration: 0) {
                self.layoutIfNeeded()
            }
        }
    }

    static var reuseIdentifier: String {
        return "HeaderCollectionCell"
    }
}
