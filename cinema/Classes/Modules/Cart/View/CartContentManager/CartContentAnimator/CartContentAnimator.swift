//
//  CartContentAnimator.swift
//  foodle
//
//  Created by incetro on 18/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - CartContentAnimator

protocol CartContentAnimator {

    func animate(tableView: UITableView, oldItems: inout [CartCellItem], newItems: [CartCellItem])
}
