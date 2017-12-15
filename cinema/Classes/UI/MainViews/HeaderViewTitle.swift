//
//  HeaderViewTitle.swift
//  cinema
//
//  Created by User on 10.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

class HeaderViewTitle: UITableViewHeaderFooterView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFutura(size: 19)
        label.textColor = UIColor.cnmGreyColor1
        label.text = "Новости"
        return label
    }()

    let leftView = UIView()
    let rightView = UIView()

    var title: String = "Новости" {
        didSet {
            titleLabel.text = title
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    let windowWidth = UIWindow(frame: UIScreen.main.bounds).bounds.width - 60

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = .white

        leftView.backgroundColor = .cnmDadada

        rightView.backgroundColor = .cnmDadada

        let centerView = UIView()

        centerView.addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.pinEdgesToSuperviewEdges()
//        titleLabel.trailingAnchor ~= centerView.trailingAnchor
//        titleLabel.centerYAnchor ~= centerView.centerYAnchor

        centerView.backgroundColor = .white

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
    }

    func withoutLine() {
        leftView.isHidden = true
        rightView.isHidden = true
    }
}
