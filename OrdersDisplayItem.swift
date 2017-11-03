//
//  OrdersDisplayItem.swift
//  foodle
//
//  Created by Mac on 06.09.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol OrdersDisplayItem {

    var name: String { get }
    var address: String { get }
    var typeWithNumber: String { get }
    var price: String { get }
    var dateWithPerson: String { get }
}

protocol OrdersDisplayItemOutput: class {

    func needOpenOrder()

//    func needCheckTableInOrder()
}
