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

    var isLoad: Bool = false
    let actionsImage: UIImageView = {
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

    }

    func isCollections() {
        posterView.addSubview(actionsImage.prepareForAutoLayout())
        actionsImage.trailingAnchor ~= posterView.trailingAnchor - 3
        actionsImage.topAnchor ~= posterView.topAnchor + 3
    }

    static var reuseIdentifier: String {
        return "FilmsCollectionCell"
    }

    override func layoutSubviews() {

        super.layoutSubviews()

    }
}
