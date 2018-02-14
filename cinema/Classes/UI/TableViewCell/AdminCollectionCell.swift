//
//  CollectionCell.swift
//  cinema
//
//  Created by iOS on 11.12.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - CollectionCell

class AdminCollectionCell: UITableViewCell {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFuturaMedium(size: 20)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    private let newsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.cnm3a3a3a
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    let windowWidth = UIWindow(frame: UIScreen.main.bounds).bounds.width - 58

    required init?(coder _: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        contentView.backgroundColor = .white

        autoresizesSubviews = true

        let mainView = UIView()
        contentView.addSubview(mainView.prepareForAutoLayout())
        mainView.topAnchor ~= contentView.topAnchor + 5
        mainView.leadingAnchor ~= contentView.leadingAnchor + 29
        mainView.trailingAnchor ~= contentView.trailingAnchor - 30
        mainView.bottomAnchor ~= contentView.bottomAnchor - 5

        mainView.addSubview(newsImage.prepareForAutoLayout())
        newsImage.pinEdgesToSuperviewEdges()
        newsImage.heightAnchor ~= windowWidth / 320 * 131

        mainView.addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.centerXAnchor ~= newsImage.centerXAnchor
        titleLabel.centerYAnchor ~= newsImage.centerYAnchor
        titleLabel.leadingAnchor ~= newsImage.leadingAnchor + 20
        titleLabel.trailingAnchor ~= newsImage.trailingAnchor - 20
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func setInfo(name: String, imageUrl: String) {
        titleLabel.text = name
        newsImage.kf.setImage(with: URL(string: imageUrl))
    }

    static var reuseIdentifier: String {
        return "AdminCollectionCell"
    }
}
