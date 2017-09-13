//
//  ProfileCardsViewContentManager.swift
//  foodle
//
//  Created by incetro on 26/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - ProfileCardsViewContentManager

class ProfileCardsViewContentManager: NSObject {

    weak var delegate: ProfileCardsViewContentManagerDelegate?

    var cards: [Card] = [] {

        didSet {

            tableView?.reloadData()
        }
    }

    var tableView: UITableView? {

        didSet {

            tableView?.dataSource = self
            tableView?.delegate = self
        }
    }
}

// MARK: - UITableViewDataSource

extension ProfileCardsViewContentManager: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return cards.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)

        cell.accessoryType = .disclosureIndicator

        cell.textLabel?.text = "Карта"
        cell.textLabel?.font = UIFont.fdlSystemRegular(size: 13)
        cell.textLabel?.textColor = UIColor.fdlWarmGrey

        cell.detailTextLabel?.text = "**** **** **** \(cards[indexPath.row].last4)"
        cell.detailTextLabel?.font = UIFont.fdlSystemRegular(size: 15)
        cell.detailTextLabel?.textColor = UIColor.fdlGreyishBrown

        cell.backgroundColor = .clear

        cell.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

        cell.selectionStyle = .none

        return cell
    }
}

// MARK: - UITableViewDelegate

extension ProfileCardsViewContentManager: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        delegate?.didSelectCard(cards[indexPath.row])
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 50
    }
}
