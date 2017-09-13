//
// Created by incetro on 12/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - CategoryMenuModuleFactory

class CategoryMenuModuleFactory {

    let moduleCreator: AppRouterModuleCreator

    init(moduleCreator: AppRouterModuleCreator) {

        self.moduleCreator = moduleCreator
    }

    func createModule(categoryID: Int, restaurant: FullRestaurant) -> CategoryMenuViewController {

        let module = moduleCreator.createModule(for: .categoryMenu(categoryID: categoryID, restaurant: restaurant))

        guard let controller = module as? CategoryMenuViewController else {

            fatalError("Cannot create CategoryMenuViewController")
        }

        return controller
    }
}

// MARK: - RestaurantMenuPresenter

class RestaurantMenuPresenter {

    weak var view: RestaurantMenuViewInput!
    var interactor: RestaurantMenuInteractorInput!
    var router: RestaurantMenuRouterInput!
    weak var output: RestaurantMenuModuleOutput?

    let factory: CategoryMenuModuleFactory

    var cart: Cart? {

        didSet {

            if let cart = cart {

                view.updateCartCount(cart.count)

                for (categoryID, _) in submodules {

                    shouldUpdateTab(withCategoryID: categoryID)
                }
            }
        }
    }

    var submodules: [Int : CategoryMenuModuleInput] = [:]

    let selectedCategoryID: Int
    let restaurant: FullRestaurant

    init(selectedCategoryID: Int, restaurant: FullRestaurant, factory: CategoryMenuModuleFactory) {

        self.selectedCategoryID = selectedCategoryID
        self.restaurant = restaurant
        self.factory = factory
    }
}

// MARK: - RestaurantMenuViewOutput

extension RestaurantMenuPresenter: RestaurantMenuViewOutput {

    func shouldUpdateTab(withCategoryID categoryID: Int) {

        didSelectPage(withCategoryID: categoryID)
    }

    func updateCart() {

        interactor.obtainCart()
    }

    func viewIsReady() {

        log.verbose("RestaurantMenu is ready")
        view.setupInitialState(withRestaurant: restaurant)

        let controllers = restaurant.categories.map { category in

            (category.id, self.factory.createModule(categoryID: category.id, restaurant: restaurant))
        }

        for (categoryID, controller) in controllers {

            if let module = controller.output as? CategoryMenuModuleInput {

                module.setModuleOutput(self)
                submodules[categoryID] = module
            }
        }

        var items: [(UIViewController, String)] = []

        for (categoryID, controller) in controllers {

            if let categoryName = restaurant.categories.first(where: { $0.id == categoryID })?.name {

                items.append((controller, categoryName))
            }
        }

        view.setupTabs(items, selectedCategoryID: selectedCategoryID)

        interactor.obtainProducts(restaurant: restaurant)
        interactor.obtainCart()
    }

    func openCartButtonTapped() {

        router.openCart()
    }

    func didSelectPage(withCategoryID categoryID: Int) {

        guard let products = cart?.products else {

            return
        }

        let mapper: ProductsMapper = ProductsMapperImplementation()

        submodules[categoryID]?.updateProducts(mapper.map(products))
    }
}

// MARK: - CategoryMenuModuleOutput

extension RestaurantMenuPresenter: CategoryMenuModuleOutput {

    func updateCart(_ cart: Cart) {

        self.cart = cart
    }
}

// MARK: - RestaurantMenuInteractorOutput

extension RestaurantMenuPresenter: RestaurantMenuInteractorOutput {

    func obtainCartSuccess(cart: Cart) {

        self.cart = cart
    }

    func obtainCartFailure(errorMessage: String) {

        log.error("Finish fetch cart count with error: \(errorMessage)")
        router.performTransitionToNetworkAlert(message: errorMessage)
    }

    func obtainProductsSuccess(products: [Int : [Product]]) {

        for (categoryID, products) in products {

            submodules[categoryID]?.setActualData(products)
        }
    }

    func obtainProductsFailure(errorMessage: String) {

        log.error("Finish fetch all products with error: \(errorMessage)")
        router.performTransitionToNetworkAlert(message: errorMessage)
    }
}
