//
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class RatingStarView: UIView {

    var text: String? {
        didSet {
            ratingLabel.text = text

            guard let rating = text, !rating.isEmpty else {
                isHidden = true
                return
            }
            isHidden = false
        }
    }

    private let ratingLabel = UILabel()
    private let starImageView = UIImageView()

    required init(coder _: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init() {
        super.init(frame: .zero)

        ratingLabel.font = .fdlSystemMedium(size: 15)
        ratingLabel.textColor = .fdlGreyishBrown
        addSubview(ratingLabel.prepareForAutoLayout())
        ratingLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 800), for: .horizontal)
        ratingLabel.pinEdgesToSuperviewEdges(excluding: .right)

        addSubview(starImageView.prepareForAutoLayout())
        starImageView.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 900), for: .horizontal)
        starImageView.centerYAnchor ~= ratingLabel.centerYAnchor - 1
        starImageView.leadingAnchor ~= ratingLabel.trailingAnchor + 3
        starImageView.trailingAnchor ~= trailingAnchor
    }
}
