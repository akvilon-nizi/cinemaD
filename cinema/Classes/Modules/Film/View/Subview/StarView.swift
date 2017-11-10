//
//  StarView.swift
//  cinema
//
//  Created by  iMac on 09.11.2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - StarView

class StarView: UIView {

    private let contentView = UIView()

    let titleLabel: UILabel = {

        let titleLabel = UILabel()

        titleLabel.text = L10n.slide1ButtonText
        titleLabel.font = UIFont.fdlGothamProMedium(size: 18)
        titleLabel.textColor = UIColor.cnmBlueLight
        titleLabel.textAlignment = .center

        return titleLabel
    }()

    let button = UIButton().setProperty()

    override init(frame: CGRect) {

        super.init(frame: frame)

        addSubview(contentView.prepareForAutoLayout())
        contentView.pinEdgesToSuperviewEdges()
        widthAnchor ~= 20

        contentView.addSubview(button.prepareForAutoLayout())
        button.topAnchor ~= contentView.topAnchor
        button.centerXAnchor ~= contentView.centerXAnchor

        contentView.addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.centerXAnchor ~= contentView.centerXAnchor
        titleLabel.topAnchor ~= button.bottomAnchor + 15
        titleLabel.heightAnchor ~= 15
        titleLabel.widthAnchor ~= 30
    }

    func setState(_ isSelect: Bool, labelIsHidden: Bool) {
        button.isSelected = isSelect
        titleLabel.isHidden = labelIsHidden
    }

    func setTagView(_ tag: Int) {
        button.tag = tag
        titleLabel.text = String(tag + 1)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension UIButton {
    func setProperty() -> UIButton {
        self.setImage(Asset.Cinema.unselectStar.image, for: .normal)
        self.setImage(Asset.Cinema.selectStar.image, for: .selected)
        self.widthAnchor ~= 19
        self.heightAnchor ~= 17
        return self
    }
}
