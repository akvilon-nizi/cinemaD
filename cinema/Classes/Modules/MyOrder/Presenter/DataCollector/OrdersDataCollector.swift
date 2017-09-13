//
//  OrdersDataCollector.swift
//  foodle
//
//  Created by Mac on 06.09.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import Foundation

class OrdersDataCollector {

    var orders: [Order] = []
    var displayItems: [OrdersDisplayItem] = []

    fileprivate weak var itemOutput: OrdersItemOutput?

    init(itemOutput: OrdersItemOutput?) {
        self.itemOutput = itemOutput
    }

    func update(orders: [Order]) {
        self.orders = orders

        displayItems = orders.map {
            OrdersItem(order: $0, output: itemOutput)
        }
    }
}
