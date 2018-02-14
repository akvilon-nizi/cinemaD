//
//  LikedView.swift
//  cinema
//
//  Created by iOS on 16.12.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

protocol LikedViewDelegate: class {
    func changeStatus(isLike: Bool, isSelect: Bool)
}

class LikedView: UIView {

    weak var delegate: LikedViewDelegate?

    var count: Int = 0 {
        didSet {
            countLabel.text = String(describing: count)
        }
    }

    private let countLabel: UILabel = {
        let label = UILabel()
        let size: CGFloat = 14
        label.text = "0"
        label.font = UIFont.cnmFuturaLight(size: size)
        label.numberOfLines = 1
        return label
    }()

    private let likeButton: UIButton = {
        let button = UIButton()
        button.heightAnchor ~= 33
        button.widthAnchor ~= 33
        return button
    }()

    private var isLike: Bool = true

    var didSelect: Bool = false {
        didSet {
            if didSelect {
                countLabel.textColor = UIColor.setColorGray(white: 46)
                likeButton.isSelected = true
            } else {
                countLabel.textColor = UIColor.setColorGray(white: 46, alpha: 0.4)
                likeButton.isSelected = false
            }
        }
    }

    private let inset: CGFloat = 40.0

    required init(coder _: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init(isLike: Bool) {
        self.isLike = isLike
        super.init(frame: .zero)

        heightAnchor ~= 33
        widthAnchor ~= (UIWindow(frame: UIScreen.main.bounds).bounds.width - 1) / 2

        addSubview(likeButton.prepareForAutoLayout())

        addSubview(countLabel.prepareForAutoLayout())
        countLabel.centerYAnchor ~= centerYAnchor

        if isLike {
            likeButton.centerYAnchor ~= centerYAnchor - 5
            likeButton.trailingAnchor ~= trailingAnchor - inset
            countLabel.trailingAnchor ~= likeButton.leadingAnchor - 10
            likeButton.setImage(Asset.Cinema.likeUnselect.image, for: .normal)
            likeButton.setImage(Asset.Cinema.likeSelect.image, for: .selected)
        } else {
            likeButton.centerYAnchor ~= centerYAnchor + 5
            likeButton.leadingAnchor ~= leadingAnchor + inset
            countLabel.leadingAnchor ~= likeButton.trailingAnchor + 10
            likeButton.setImage(Asset.Cinema.dislikeUnselect.image, for: .normal)
            likeButton.setImage(Asset.Cinema.dislikeSelect.image, for: .selected)
        }

        likeButton.addTarget(self, action: #selector(changeStatus), for: .touchUpInside)
    }

    func changeStatus() {
        didSelect = !didSelect
        delegate?.changeStatus(isLike: isLike, isSelect: didSelect)
        if didSelect {
            count += 1
        } else {
            count -= 1
        }
    }
}
