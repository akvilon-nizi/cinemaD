//
//  CartContentAnimatorImplementation.swift
//  foodle
//
//  Created by incetro on 18/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - CartContentAnimatorImplementation

class CartContentAnimatorImplementation: CartContentAnimator {

    func animate(tableView: UITableView, oldItems: inout [CartCellItem], newItems: [CartCellItem]) {

        tableView.beginUpdates()

        var currentOldItems = oldItems

        var removedPaths: [IndexPath] = []

        for old in currentOldItems {

            if newItems.index(where: { $0.id == old.id }) == nil {

                guard let index = currentOldItems.index(where: { $0.id == old.id }) else {

                    return
                }

                let indexPath = IndexPath(row: index, section: 0)

                removedPaths.append(indexPath)
                currentOldItems.remove(at: indexPath.row)
            }
        }

        oldItems = currentOldItems

        tableView.deleteRows(at: removedPaths, with: .left)

        tableView.endUpdates()
    }
}
