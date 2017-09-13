//
//  CartCellItemBuilderImplementation.swift
//  foodle
//
//  Created by incetro on 18/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import Foundation

// MARK: - CartCellItemBuilderImplementation

class CartCellItemBuilderImplementation: CartCellItemBuilder {

    func cartItem(fromProduct product: CartProduct) -> CartCellItem {

        return CartCellItem(id: product.id,
                            name: product.name,
                            image: product.image,
                            weight: "\(product.weight) г",
                            quantity: product.quantity,
                            price: "\(product.price) \u{20BD}")
    }
}
