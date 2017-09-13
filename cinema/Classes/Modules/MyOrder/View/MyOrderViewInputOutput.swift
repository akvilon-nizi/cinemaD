//
// Created by DanilaLyahomskiy on 05/09/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol MyOrderViewInput: class {

    func setupInitialState(withOrders orders: [Order])

    func update(displayItems: [OrdersDisplayItem])

    func showEmptyLoading()

    func show(error: String)
}

protocol MyOrderViewOutput {

    func viewIsReady()

    func close()

    func reloadData()
}
