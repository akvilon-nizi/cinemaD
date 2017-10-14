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

    var linkUrlImage: Bool = false {
        didSet {
            if linkUrlImage {
                posterView.image = Asset.Cinema.assa.image
            } else {
                posterView.image = Asset.Cinema.aqqa.image
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(posterView.prepareForAutoLayout())
        posterView.image = Asset.Cinema.aqqa.image
        posterView.pinEdgesToSuperviewEdges()
        //        youtubeView.layer.cornerRadius = 5.0
        //        youtubeView.layer.masksToBounds = true
    }

    static var reuseIdentifier: String {
        return "FilmsCollectionCell"
    }
}
