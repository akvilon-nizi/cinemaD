//
// Created by incetro on 22/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class CategoryMenuPresenter {

    weak var view: CategoryMenuViewInput!
    var interactor: CategoryMenuInteractorInput!
    var router: CategoryMenuRouterInput!
    weak var output: CategoryMenuModuleOutput?

    var currentProductID: Int?

    let categoryID: Int
    let restaurant: FullRestaurant

    init(categoryID: Int, restaurant: FullRestaurant) {

        self.categoryID = categoryID
        self.restaurant = restaurant
    }
}

// MARK: - CategoryMenuViewOutput

extension CategoryMenuPresenter: CategoryMenuViewOutput {

    func viewIsReady() {
        log.verbose("CategoryMenu is ready")
    }

    func didTapAddProduct(withProductID productID: Int) {

        interactor.incrementProductCountInCart(productID: productID)
    }

    func incrementProductCount(productID: Int) {

        currentProductID = productID
        interactor.incrementProductCountInCart(productID: productID)
    }

    func decrementProductCount(productID: Int) {

        currentProductID = productID
        interactor.decrementProductCountInCart(productID: productID)
    }

    func neddToRefresh() {

        interactor.obtainProducts(restaurantID: restaurant.id, categoryID: categoryID)
    }

    func showProductInfo(productID: Int) {
        router.openCardOfProduct(productID: productID)
    }
}

extension CategoryMenuPresenter: CategoryMenuModuleInput {

    func setActualData(_ products: [Product]) {

        view.setupInitialState(withProducts: products)
    }

    func setModuleOutput(_ output: CategoryMenuModuleOutput) {

        self.output = output
    }

    func updateProducts(_ products: [Product]) {

        view.updateProducts(products)
    }
}

// MARK: - CategoryMenuInteractorOutput

extension CategoryMenuPresenter: CategoryMenuInteractorOutput {

    func obtainProductsFailure(errorMessage: String) {

        log.error("Finish fetch categories with error: \(errorMessage)")
        router.performTransitionToNetworkAlert(message: errorMessage)
    }

    func obtainProductsSuccess(products: [Product]) {

        log.verbose("Success fetch restaurants count: \(products.count)")
        view.updateContent(withProducts: products)
    }

    func incrementProductCountInCartSuccess(product: Product, cart: Cart) {

        view.updateProduct(product)
        output?.updateCart(cart)
    }

    func incrementProductCountInCartFailure(errorMessage: String) {

        log.error("Increment product count in cart failure with error: \(errorMessage)")
        router.performTransitionToNetworkAlert(message: errorMessage)
    }

    func decrementProductCountInCartSuccess(product: Product?, cart: Cart) {

        if let product = product {

            view.updateProduct(product)

        } else {

            guard let productID = currentProductID else {

                return
            }

            view.clearProductCount(productID)
        }

        output?.updateCart(cart)
    }

    func decrementProductCountInCartFailure(errorMessage: String) {

        log.error("Decrement product count in cart failure with error: \(errorMessage)")
        router.performTransitionToNetworkAlert(message: errorMessage)
    }
}
