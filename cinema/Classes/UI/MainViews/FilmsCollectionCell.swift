//
//  FilmsCollectionCell.swift
//  cinema
//
//  Created by User on 11.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit
import Kingfisher

class FilmsCollectionCell: UICollectionViewCell {
    fileprivate let posterView = UIImageView()
    fileprivate let rateView = UIView()

    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFuturaMedium(size: 9)
        label.textColor = UIColor.cnmBlueLight
        return label
    }()

    var isLoad: Bool = false
    fileprivate let actionsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.heightAnchor ~= 28
        imageView.widthAnchor ~= 28
        return imageView
    }()

    var isAdd: Bool = false
    var isCheck: Bool = false {
        didSet {
            if isCheck {
                actionsImage.image = isAdd ? Asset.Kinobase.check28.image : Asset.Kinobase.remove28.image
            } else {
                actionsImage.image = nil
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    var linkUrlImage: String = "" {
        didSet {
            posterView.kf.indicatorType = .activity
            posterView.kf.setImage(with: URL(string: linkUrlImage))
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(posterView.prepareForAutoLayout())
        posterView.backgroundColor = UIColor.lightGray
        posterView.pinEdgesToSuperviewEdges()
        posterView.layer.cornerRadius = 5.0
        posterView.layer.masksToBounds = true

        let starView = UIImageView(image: Asset.Cinema.selectStar.image)
        rateView.addSubview(starView.prepareForAutoLayout())
        starView.centerYAnchor ~= rateView.centerYAnchor
        starView.leadingAnchor ~= rateView.leadingAnchor + 3
        starView.heightAnchor ~= 17 / 2
        starView.widthAnchor ~= 19 / 2

        rateView.addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.centerYAnchor ~= rateView.centerYAnchor
        titleLabel.leadingAnchor ~= starView.trailingAnchor + 2
        titleLabel.trailingAnchor ~= rateView.trailingAnchor - 3
        titleLabel.text = String(8)

        rateView.heightAnchor ~= 15
        rateView.layer.cornerRadius = 7.5
        rateView.backgroundColor = .white
        posterView.addSubview(rateView.prepareForAutoLayout())
        rateView.leadingAnchor ~= posterView.leadingAnchor + 5
        rateView.topAnchor ~= posterView.topAnchor + 5

        rateView.isHidden = true
    }

    func isCollections() {
        posterView.addSubview(actionsImage.prepareForAutoLayout())
        actionsImage.trailingAnchor ~= posterView.trailingAnchor - 3
        actionsImage.topAnchor ~= posterView.topAnchor + 3
    }

    func setRating(_ rate: Int) {
        titleLabel.text = String(rate)
        rateView.isHidden = false
    }

    static var reuseIdentifier: String {
        return "FilmsCollectionCell"
    }

    override func layoutSubviews() {

        super.layoutSubviews()

    }
}
