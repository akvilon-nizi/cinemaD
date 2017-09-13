//
//  ProductsMapper.swift
//  foodle
//
//  Created by incetro on 16/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import Foundation

// MARK: - ProductsMapper

protocol ProductsMapper {

    func map(_ cartProduct: CartProduct) -> Product
}

extension ProductsMapper {

    func map(_ cartProducts: [CartProduct]) -> [Product] {

        return cartProducts.map {

            self.map($0)
        }
    }
}
