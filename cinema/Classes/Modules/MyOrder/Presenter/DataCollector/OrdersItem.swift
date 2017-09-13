//
//  OrdersItem.swift
//  foodle
//
//  Created by Mac on 06.09.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import Foundation
import CoreLocation

protocol OrdersItemOutput: class {

    func needOpenOrder(with id: Int)

//    func needCheckTableInRestaurant(with id: Int)
}

class OrdersItem: OrdersDisplayItem {

    private(set) var name: String
    private(set) var address: String
    private(set) var typeWithNumber: String
    private(set) var price: String
    private(set) var dateWithPerson: String

    fileprivate let order: Order
    fileprivate weak var output: OrdersItemOutput?

    init(order: Order, output: OrdersItemOutput?) {
        self.order = order
        self.output = output

        name = order.restaurant.name
        address = order.restaurant.address
        typeWithNumber = order.type == .booking ? L10n.myOrdersBooking(String(order.number)) : L10n.myOrdersExport(String(order.number))
        price = L10n.myOrdersPrice(String(order.cost))

        let calendar = NSCalendar.current
        let date1 = calendar.startOfDay(for: Date())
        let date2 = calendar.startOfDay(for: order.date)
        let checkDays = calendar.dateComponents([.day], from: date1, to: date2).day

        let localized = String.localizedStringWithFormat(String(
            format: NSLocalizedString("%d person(s)", comment: ""),
            locale: Locale(identifier: "RU_ru"),
            order.persons))

        let timeWithPerson = " " + L10n.myOrdersInTime(order.date.hourMinutes) + " " + L10n.myOrdersOnPersons(localized)

        dateWithPerson = ""

        if checkDays == 0 {
            dateWithPerson = L10n.myOrdersToday + " " + timeWithPerson
        } else if checkDays == 1 {
            dateWithPerson = L10n.myOrdersTomorrow + " " + timeWithPerson
        } else {
            dateWithPerson = order.date.monthMedium + " " + timeWithPerson
        }
    }
}

// MARK: - RestaurantsDisplayItemOutput

extension OrdersItem: OrdersDisplayItemOutput {

    func needOpenOrder() {
//        output?.needOpenRestaurant(with: restaurant.id)
    }

    func needCheckTableInOrder() {
//        output?.needCheckTableInRestaurant(with: restaurant.id)
    }
}
