//
// Created by incetro on 17/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class CartPresenter {

    weak var view: CartViewInput!
    var interactor: CartInteractorInput!
    var router: CartRouterInput!
    weak var output: CartModuleOutput?
}

// MARK: - CartViewOutput

extension CartPresenter: CartViewOutput {

    func viewIsReady() {
        log.verbose("Cart is ready")
        interactor.obtainCart()
    }

    func clearCartButtonTapped() {

        interactor.clearCart()
    }

    func incrementProductInCart(productID: Int) {

        interactor.incrementProductInCart(productID: productID)
    }

    func decrementProductInCart(productID: Int) {

        interactor.decrementProductInCart(productID: productID)
    }
}

// MARK: - CartInteractorOutput

extension CartPresenter: CartInteractorOutput {

    func incrementProductInCartSuccess(cart: Cart) {

        view.refreshState(withCart: cart)
    }

    func decrementProductInCartSuccess(cart: Cart) {

        view.refreshState(withCart: cart)
    }

    func incrementProductInCartFailure(errorMessage: String) {

        log.error("Finish increment product cart with error: \(errorMessage)")
        router.performTransitionToNetworkAlert(message: errorMessage)
    }

    func decrementProductInCartFailure(errorMessage: String) {

        log.error("Finish decrement product cart with error: \(errorMessage)")
        router.performTransitionToNetworkAlert(message: errorMessage)
    }

    func clearCartSucces(cart: Cart) {

        view.refreshState(withCart: cart)
    }

    func clearCartFailure(errorMessage: String) {

        log.error("Finish clear cart with error: \(errorMessage)")
        router.performTransitionToNetworkAlert(message: errorMessage)
    }

    func obtainCartSucces(cart: Cart) {

        view.refreshState(withCart: cart)
    }

    func obtainCartFailure(errorMessage: String) {

        log.error("Finish fetch cart with error: \(errorMessage)")
        router.performTransitionToNetworkAlert(message: errorMessage)
    }
}
