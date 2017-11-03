//
//  SelectorHeaderView.swift
//  cinema
//
//  Created by User on 10.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

class HeaderViewOpenned: UITableViewHeaderFooterView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFutura(size: 19)
        label.textColor = UIColor.cnmGreyColor1
        label.text = "Новости"
        return label
    }()

    var title: String = "Новости" {
        didSet {
            titleLabel.text = title
        }
    }

    let buttonImage = UIImageView(image: Asset.Cinema.MainView.isOpen.image)

    var isOpen: Bool = false {
        didSet {
            if !isOpen {
                buttonImage.image = Asset.Cinema.MainView.isOpen.image
            } else {
                buttonImage.image = Asset.Cinema.MainView.isClose.image
            }
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    let windowWidth = UIWindow(frame: UIScreen.main.bounds).bounds.width - 60

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        backgroundColor = .red

        let leftView = UIView()
        leftView.backgroundColor = .cnmDadada

        let rightView = UIView()
        rightView.backgroundColor = .cnmDadada

        let centerView = UIView()

        centerView.addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.leadingAnchor ~= centerView.leadingAnchor
        titleLabel.centerYAnchor ~= centerView.centerYAnchor

        centerView.addSubview(buttonImage.prepareForAutoLayout())
        buttonImage.trailingAnchor ~= centerView.trailingAnchor
        buttonImage.centerYAnchor ~= centerView.centerYAnchor
        buttonImage.leadingAnchor ~= titleLabel.trailingAnchor + 10
        buttonImage.heightAnchor ~= 9
        buttonImage.widthAnchor ~= 14

        addSubview(centerView.prepareForAutoLayout())
        centerView.centerXAnchor ~= centerXAnchor
        centerView.centerYAnchor ~= centerYAnchor

        addSubview(leftView.prepareForAutoLayout())
        leftView.heightAnchor ~= 1
        leftView.centerYAnchor ~= centerYAnchor
        leftView.leadingAnchor ~= leadingAnchor + 30
        leftView.trailingAnchor ~= centerView.leadingAnchor - 20

        addSubview(rightView.prepareForAutoLayout())
        rightView.heightAnchor ~= 1
        rightView.centerYAnchor ~= centerYAnchor
        rightView.trailingAnchor ~= trailingAnchor - 30
        rightView.leadingAnchor ~= centerView.trailingAnchor + 20

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tap)
    }

    @objc func handleTap() {
        isOpen = !isOpen
    }
}
