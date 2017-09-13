//
//  CartContentManager.swift
//  foodle
//
//  Created by incetro on 17/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - CartContentManagerDelegate

protocol CartContentManagerDelegate: class {

    func plusButtonTapped(productID: Int)

    func minusButtonTapped(productID: Int)
}

// MARK: - CartContentManager

class CartContentManager: NSObject {

    weak var delegate: CartContentManagerDelegate?

    let itemBuilder: CartCellItemBuilder = CartCellItemBuilderImplementation()
    let animator: CartContentAnimator = CartContentAnimatorImplementation()

    fileprivate var products: [CartCellItem] = []

    var tableView: UITableView? {

        didSet {

            tableView?.delegate = self
            tableView?.dataSource = self
        }
    }

    func setProducts(_ products: [CartProduct]) {

        guard let tableView = tableView else {

            return
        }

        let comparator = { (first: CartCellItem, second: CartCellItem) in

            first.id < second.id
        }

        let products = itemBuilder.cartItems(fromProducts: products).sorted(by: comparator)

        if self.products.count <= products.count || products.isEmpty {

            self.products = products
            self.products.sort(by: comparator)
            tableView.reloadData()

        } else {

            animator.animate(tableView: tableView, oldItems: &self.products, newItems: products)
        }
    }
}

// MARK: - UITableViewDataSource

extension CartContentManager: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = CartCell()

        cell.setData(products[indexPath.row])
        cell.delegate = self

        return cell
    }
}

// MARK: - UITableViewDelegate

extension CartContentManager: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 110
    }
}

// MARK: - CartCellDelegate

extension CartContentManager: CartCellDelegate {

    func plusButtonTapped(item: CartCellItem) {

        delegate?.plusButtonTapped(productID: item.id)
    }

    func minusButtonTapped(item: CartCellItem) {

        delegate?.minusButtonTapped(productID: item.id)
    }
}
