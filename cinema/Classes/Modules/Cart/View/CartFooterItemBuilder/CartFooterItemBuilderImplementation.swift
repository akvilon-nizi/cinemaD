//
//  CartFooterItemBuilderImplementation.swift
//  foodle
//
//  Created by incetro on 18/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import Foundation

// MARK: - CartFooterItemBuilderImplementation

class CartFooterItemBuilderImplementation: CartFooterItemBuilder {

    func cartFooterItem(fromCart cart: Cart) -> CartFooterItem {

        return CartFooterItem(price: "\(cart.cost) \u{20BD}", weight: "\(cart.weight) г")
    }
}
