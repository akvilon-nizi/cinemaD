//
//  RestaurantMenuView.swift
//  foodle
//
//  Created by incetro on 08/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - RestaurantMenuView

class RestaurantMenuView: UIView {

    static let cellHeight: CGFloat = 55

    private let label = UILabel(frame: .zero)
    private let tableView = UITableView(frame: .zero)
    private let contentManager: RestaurantMenuViewContentManager

    func setDelegate(_ delegate: RestaurantMenuViewDelegate) {

        contentManager.delegate = delegate
    }

    init(contentManager: RestaurantMenuViewContentManager) {

        self.contentManager = contentManager

        super.init(frame: .zero)

        backgroundColor = .clear
    }

    func setup(withItems items: [RestaurantMenuItem]) {

        setupLabel()
        setupTableView(withItems: items)
    }

    private func setupLabel() {

        addSubview(label)

        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.font = UIFont.fdlGothamProMedium(size: 20)
        label.text = L10n.restaurantMenuTitle
        label.textColor = UIColor.fdlGreyishBrown
    }

    private func setupTableView(withItems items: [RestaurantMenuItem]) {

        addSubview(tableView)

        tableView.separatorStyle = .none

        contentManager.tableView = tableView
        contentManager.items = items

        let height: CGFloat = CGFloat(items.count) * RestaurantMenuView.cellHeight

        tableView.alwaysBounceVertical = false
        tableView.backgroundColor = .clear
        tableView.clipsToBounds = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: height).isActive = true
        tableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 13).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
