//
// Created by incetro on 12/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

protocol RestaurantMenuViewInput: class {

    func updateCartCount(_ cartCount: Int)
    func setupInitialState(withRestaurant restaurant: FullRestaurant)
    func setupTabs(_ items: [(UIViewController, String)], selectedCategoryID: Int)
}

protocol RestaurantMenuViewOutput {

    func viewIsReady()

    func shouldUpdateTab(withCategoryID categoryID: Int)

    func openCartButtonTapped()

    func updateCart()

    func didSelectPage(withCategoryID categoryID: Int)
}
