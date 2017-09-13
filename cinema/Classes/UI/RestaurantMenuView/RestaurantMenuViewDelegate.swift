//
//  RestaurantMenuViewDelegate.swift
//  foodle
//
//  Created by incetro on 09/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import Foundation

// MARK: - RestaurantMenuViewDelegate

protocol RestaurantMenuViewDelegate: class {

    func didSelectMenuItem(withItemID itemID: Int)
}
