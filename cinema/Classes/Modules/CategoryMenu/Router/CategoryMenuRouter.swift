//
// Created by incetro on 22/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class CategoryMenuRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - CategoryMenuRouterInput

extension CategoryMenuRouter: CategoryMenuRouterInput {
    func openCardOfProduct(productID: Int) {
        appRouter.transition(to: .cardOfProduct(productID: productID))
    }
}
