//
//  ProfileCardsView.swift
//  foodle
//
//  Created by incetro on 26/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - ProfileCardsView

class ProfileCardsView: UIView {

    var height: CGFloat {

        if !contentManager.cards.isEmpty {

            return CGFloat(contentManager.cards.count * 50) + 39
        }

        return 89
    }

    weak var delegate: ProfileCardsViewDelegate?

    fileprivate let contentManager = ProfileCardsViewContentManager()

    fileprivate let backgroundView: ShadowView = {

        let backgroundView = ShadowView()

        backgroundView.backgroundColor = .white

        return backgroundView
    }()

    fileprivate let tableView: UITableView = {

        let tableView = UITableView()

        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.isHidden = true

        return tableView
    }()

    fileprivate let addCardLabel: UILabel = {

        let addCardLabel = UILabel()

        addCardLabel.text = "Добавить карту"
        addCardLabel.font = UIFont.fdlSystemRegular(size: 15)
        addCardLabel.textColor = UIColor.fdlGreyishBrown

        return addCardLabel
    }()

    fileprivate let addCardButton: UIButton = {

        let addCardButton = UIButton()

        addCardButton.setImage(Asset.Profile.profilePlus.image, for: .normal)

        return addCardButton
    }()

    fileprivate let titleLabel: UILabel = {

        let titleLabel = UILabel()

        titleLabel.text = "Кредитные карты"
        titleLabel.font = UIFont.fdlGothamProMedium(size: 20)
        titleLabel.textColor = UIColor.fdlGreyishBrown

        return titleLabel
    }()

    override init(frame: CGRect) {

        super.init(frame: frame)

        contentManager.tableView = tableView
        contentManager.delegate = self

        setupTitleLabel()
        setupBackgroundView()
        setupTableView()
        setupAddCardLabel()
        setupAddCardButton(isTop: false)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setCards(_ cards: [Card]) {

        if !cards.isEmpty {

            tableView.isHidden = false
            addCardLabel.isHidden = true
        }

        setupAddCardButton(isTop: !cards.isEmpty)

        contentManager.cards = cards
    }

    func didTapAddCardButton() {

        delegate?.didTapAddCardButton()
    }

    private func setupTitleLabel() {

        addSubview(titleLabel.prepareForAutoLayout())

        titleLabel.leadingAnchor ~= leadingAnchor + 25
        titleLabel.topAnchor ~= topAnchor
        titleLabel.heightAnchor ~= 20
    }

    private func setupAddCardButton(isTop: Bool) {

        if addCardButton.superview != nil {

            addCardButton.removeFromSuperview()
        }

        if !addCardButton.constraints.isEmpty {

            addCardButton.removeConstraints(addCardButton.constraints)
        }

        if isTop {

            addSubview(addCardButton.prepareForAutoLayout())

            addCardButton.centerYAnchor ~= titleLabel.centerYAnchor
            addCardButton.trailingAnchor ~= trailingAnchor - 15

        } else {

            backgroundView.addSubview(addCardButton.prepareForAutoLayout())

            addCardButton.centerYAnchor ~= backgroundView.centerYAnchor
            addCardButton.trailingAnchor ~= backgroundView.trailingAnchor - 15
        }

        addCardButton.widthAnchor ~= 24
        addCardButton.heightAnchor ~= addCardButton.widthAnchor

        addCardButton.addTarget(self, action: #selector(didTapAddCardButton), for: .touchUpInside)
    }

    private func setupAddCardLabel() {

        backgroundView.addSubview(addCardLabel.prepareForAutoLayout())

        addCardLabel.leadingAnchor ~= backgroundView.leadingAnchor + 15
        addCardLabel.centerYAnchor ~= backgroundView.centerYAnchor
    }

    private func setupBackgroundView() {

        addSubview(backgroundView.prepareForAutoLayout())

        backgroundView.leadingAnchor ~= leadingAnchor + 10
        backgroundView.trailingAnchor ~= trailingAnchor - 10
        backgroundView.topAnchor ~= titleLabel.bottomAnchor + 10
        backgroundView.bottomAnchor ~= bottomAnchor - 10
    }

    func setupTableView() {

        backgroundView.addSubview(tableView.prepareForAutoLayout())

        tableView.pinEdgesToSuperviewEdges()
    }
}

// MARK: - ProfileCardsViewContentManagerDelegate

extension ProfileCardsView: ProfileCardsViewContentManagerDelegate {

    func didSelectCard(_ card: Card) {

        delegate?.didSelectCard(card)
    }
}
