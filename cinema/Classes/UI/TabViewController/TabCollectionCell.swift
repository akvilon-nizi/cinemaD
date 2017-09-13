//
//  TabCollectionCell.swift
//  foodle
//
//  Created by incetro on 11/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

class TabCollectionCell: UICollectionViewCell {

    var tabItemPressedBlock: (() -> Void)?

    var option = TabPageOption() {

        didSet {

            barViewHeightConstraint?.constant = option.currentBarHeight
        }
    }

    var itemName: String? {

        didSet {

            itemLabel.text = itemName
            itemLabel.invalidateIntrinsicContentSize()
            invalidateIntrinsicContentSize()
        }
    }

    var isCurrent: Bool = false {

        didSet {

            currentBarView.isHidden = !isCurrent

            if isCurrent {

                highlightTitle()

            } else {

                unHighlightTitle()
            }

            currentBarView.backgroundColor = option.currentColor
            layoutIfNeeded()
        }
    }

    private let actionButton: UIButton = {

        let actionButton = UIButton()

        actionButton.translatesAutoresizingMaskIntoConstraints = false

        return actionButton
    }()

    private let itemLabel: UILabel = {

        let itemLabel = UILabel()

        itemLabel.translatesAutoresizingMaskIntoConstraints = false

        return itemLabel
    }()

    private let currentBarView: UIView = {

        let currentBarView = UIView()
        currentBarView.layer.cornerRadius = 1
        currentBarView.isHidden = true
        currentBarView.translatesAutoresizingMaskIntoConstraints = false

        return currentBarView
    }()

    private var barViewHeightConstraint: NSLayoutConstraint?

    override init(frame: CGRect) {

        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false

        addSubview(itemLabel)
        addSubview(actionButton)
        addSubview(currentBarView)

        itemLabel.centerXAnchor ~= contentView.centerXAnchor
        itemLabel.centerYAnchor ~= contentView.centerYAnchor

        currentBarView.leadingAnchor ~= contentView.leadingAnchor
        currentBarView.trailingAnchor ~= contentView.trailingAnchor
        currentBarView.bottomAnchor ~= contentView.bottomAnchor

        barViewHeightConstraint = currentBarView.heightAnchor ~= 2
        barViewHeightConstraint?.isActive = true

        actionButton.leadingAnchor ~= contentView.leadingAnchor
        actionButton.trailingAnchor ~= contentView.trailingAnchor
        actionButton.topAnchor ~= contentView.topAnchor
        actionButton.bottomAnchor ~= contentView.bottomAnchor

        actionButton.addTarget(self, action: #selector(tabItemTouchUpInside(_:)), for: .touchUpInside)
    }

    required init?(coder aDecoder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }

    func tabItemTouchUpInside(_ button: UIButton) {

        tabItemPressedBlock?()
    }

    func hideCurrentBarView() {

        currentBarView.isHidden = true
    }

    func showCurrentBarView() {

        currentBarView.isHidden = false
    }

    func highlightTitle() {

        itemLabel.textColor = option.currentColor
        itemLabel.font = UIFont.boldSystemFont(ofSize: option.fontSize)
    }

    func unHighlightTitle() {

        itemLabel.textColor = option.defaultColor
        itemLabel.font = UIFont.systemFont(ofSize: option.fontSize)
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {

        guard let characters = itemName?.characters else {

            return CGSize.zero
        }

        return characters.isEmpty ? CGSize.zero : intrinsicContentSize
    }

    override var intrinsicContentSize: CGSize {

        if let tabWidth = option.tabWidth, tabWidth > 0 {

            return CGSize(width: tabWidth, height: option.tabHeight)

        } else {

            return CGSize(width: itemLabel.intrinsicContentSize.width + option.tabMargin * 2, height: option.tabHeight)
        }
    }

    static var reuseIdentifier: String {

        return "TabCollectionCell"
    }
}
