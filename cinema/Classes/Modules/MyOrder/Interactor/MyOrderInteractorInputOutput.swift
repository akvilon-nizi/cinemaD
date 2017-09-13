//
// Created by DanilaLyahomskiy on 05/09/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol MyOrderInteractorInput {

    func obtainOrders(count: Int, page: Int)

}

protocol MyOrderInteractorOutput: class {

    func obtainOrdersSuccess(orders: [Order])
    func obtainOrdersFailure(errorMessage: String)

}
