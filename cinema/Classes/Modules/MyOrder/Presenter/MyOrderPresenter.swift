//
// Created by DanilaLyahomskiy on 05/09/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class MyOrderPresenter {

    weak var view: MyOrderViewInput!
    var interactor: MyOrderInteractorInput!
    var router: MyOrderRouterInput!
    weak var output: MyOrderModuleOutput?

    var dataCollector: OrdersDataCollector!

    let categories: [Category] = [Category(id: 0, name: L10n.myOrdersCurrent)]
//                                L10n.myOrdersUpcoming,
//                                L10n.myOrdersPast]

}

// MARK: - MyOrderViewOutput

extension MyOrderPresenter: MyOrderViewOutput {

    func viewIsReady() {
        log.verbose("MyOrder is ready")

//        let controllers = restaurant.categories.map { category in
//
//            (category.id, self.factory.createModule(categoryID: category.id, restaurant: restaurant))
//        }
//
//        for (categoryID, controller) in controllers {
//
//            if let module = controller.output as? CategoryMenuModuleInput {
//
//                module.setModuleOutput(self)
//                submodules[categoryID] = module
//            }
//        }
//
//        var items: [(UIViewController, String)] = []
//
//        for (categoryID, controller) in controllers {
//
//            if let categoryName = restaurant.categories.first(where: { $0.id == categoryID })?.name {
//
//                items.append((controller, categoryName))
//            }
//        }
//        
//        view.setupTabs(items, selectedCategoryID: selectedCategoryID)

        interactor.obtainOrders(count: 30, page: 1)
        view.showEmptyLoading()
    }

    func close() {
        router.close()
    }

    func reloadData() {
        interactor.obtainOrders(count: 30, page: 1)
    }
}

// MARK: - MyOrderInteractorOutput

extension MyOrderPresenter: MyOrderInteractorOutput {
    func obtainOrdersSuccess(orders: [Order]) {
        dataCollector.update(orders: orders)
//        view.setupInitialState(withOrders: orders)
        view.update(displayItems: dataCollector.displayItems)
    }

    func obtainOrdersFailure(errorMessage: String) {
        view.show(error: errorMessage)
    }
}

// MARK: - OrdersItemOutput

extension MyOrderPresenter: OrdersItemOutput {

    func needOpenOrder(with id: Int) {
        log.verbose("Need open restaurant with id: \(id)")

//        router.preformTransitionToRestaurantModule(with: id)
    }

//    func needCheckTableInRestaurant(with id: Int) {
//        log.warning("Need check table in restaurant with id: \(id)")
//    }
}
