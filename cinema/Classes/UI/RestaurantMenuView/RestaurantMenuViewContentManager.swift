//
//  RestaurantMenuViewContentManager.swift
//  foodle
//
//  Created by incetro on 09/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - RestaurantMenuViewContentManager

class RestaurantMenuViewContentManager: NSObject {

    weak var delegate: RestaurantMenuViewDelegate?

    var items: [RestaurantMenuItem] = [] {

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

extension RestaurantMenuViewContentManager: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = RestaurantMenuCell()

        cell.setData(items[indexPath.row])

        return cell
    }
}

// MARK: - UITableViewDelegate

extension RestaurantMenuViewContentManager: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        delegate?.didSelectMenuItem(withItemID: items[indexPath.row].id)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return RestaurantMenuView.cellHeight
    }
}
