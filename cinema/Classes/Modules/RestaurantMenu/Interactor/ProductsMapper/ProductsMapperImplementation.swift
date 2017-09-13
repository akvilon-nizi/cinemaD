//
//  ProductsMapperImplementation.swift
//  foodle
//
//  Created by incetro on 16/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import Foundation

// MARK: - ProductsMapperImplementation

class ProductsMapperImplementation: ProductsMapper {

    func map(_ cartProduct: CartProduct) -> Product {

        return Product(id: cartProduct.id,
                       image: cartProduct.image,
                       name: cartProduct.name,
                       price: cartProduct.price,
                       weight: cartProduct.weight,
                       quantityInCart: cartProduct.quantity)
    }
}
