//
// Created by incetro on 17/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol CartViewInput: class {

    func refreshState(withCart cart: Cart)
}

protocol CartViewOutput {

    func viewIsReady()

    func clearCartButtonTapped()

    func incrementProductInCart(productID: Int)

    func decrementProductInCart(productID: Int)
}
