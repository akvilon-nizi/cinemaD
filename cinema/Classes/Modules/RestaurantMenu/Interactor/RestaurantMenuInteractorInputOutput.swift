//
// Created by incetro on 12/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol RestaurantMenuInteractorInput {

    func obtainCart()

    func obtainProducts(restaurant: FullRestaurant)
}

protocol RestaurantMenuInteractorOutput: class {

    func obtainCartSuccess(cart: Cart)
    func obtainCartFailure(errorMessage: String)

    func obtainProductsSuccess(products: [Int: [Product]])
    func obtainProductsFailure(errorMessage: String)
}
