//
//  CartCellItemBuilder.swift
//  foodle
//
//  Created by incetro on 18/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import Foundation

// MARK: - CartCellItemBuilder

protocol CartCellItemBuilder {

    func cartItem(fromProduct product: CartProduct) -> CartCellItem
}

extension CartCellItemBuilder {

    func cartItems(fromProducts products: [CartProduct]) -> [CartCellItem] {

        return products.map {

            cartItem(fromProduct: $0)
        }
    }
}
