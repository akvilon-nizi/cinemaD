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

    static var reuseIdentifier: String {
        return "FilmsCollectionCell"
    }
}
