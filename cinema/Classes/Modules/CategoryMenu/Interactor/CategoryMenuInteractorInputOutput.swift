//
// Created by incetro on 22/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol CategoryMenuInteractorInput {

    func obtainProducts(restaurantID: Int, categoryID: Int)

    func incrementProductCountInCart(productID: Int)

    func decrementProductCountInCart(productID: Int)
}

protocol CategoryMenuInteractorOutput: class {

    func obtainProductsSuccess(products: [Product])
    func obtainProductsFailure(errorMessage: String)

    func incrementProductCountInCartSuccess(product: Product, cart: Cart)
    func incrementProductCountInCartFailure(errorMessage: String)

    func decrementProductCountInCartSuccess(product: Product?, cart: Cart)
    func decrementProductCountInCartFailure(errorMessage: String)
}
