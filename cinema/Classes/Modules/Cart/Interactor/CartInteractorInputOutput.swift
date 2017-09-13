//
// Created by incetro on 17/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol CartInteractorInput {

    func obtainCart()

    func clearCart()

    func incrementProductInCart(productID: Int)

    func decrementProductInCart(productID: Int)
}

protocol CartInteractorOutput: class {

    func obtainCartSucces(cart: Cart)
    func obtainCartFailure(errorMessage: String)

    func clearCartSucces(cart: Cart)
    func clearCartFailure(errorMessage: String)

    func incrementProductInCartSuccess(cart: Cart)
    func incrementProductInCartFailure(errorMessage: String)

    func decrementProductInCartSuccess(cart: Cart)
    func decrementProductInCartFailure(errorMessage: String)
}
