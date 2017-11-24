//
//  RewardCell.swift
//  cinema
//
//  Created by iOS on 24.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - RewardCell

import UIKit
import Kingfisher

protocol RewardCellDelegate: class {
    func setElement(_ number: Int)
}

class RewardCell: UICollectionViewCell {

    private let rewardImage = UIImageView()

    weak var delegate: RewardCellDelegate?

    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

//    var linkUrlImage: String = "" {
//        didSet {
//            posterView.kf.indicatorType = .activity
//            posterView.kf.setImage(with: URL(string: linkUrlImage))
//        }
//    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(rewardImage.prepareForAutoLayout())
        rewardImage.pinEdgesToSuperviewEdges()
        rewardImage.image = Asset.Cinema.vader.image
        rewardImage.contentMode = .scaleToFill
    }

    static var reuseIdentifier: String {
        return "RewardCell"
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
