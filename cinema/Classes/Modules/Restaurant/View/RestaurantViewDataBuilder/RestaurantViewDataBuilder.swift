//
//  RestaurantViewDataBuilder.swift
//  foodle
//
//  Created by incetro on 11/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import Foundation

// MARK: - RestaurantViewDataBuilder

class RestaurantViewDataBuilder {

    func restaurantInfo(fromRestaurant restaurant: FullRestaurant) -> RestaurantInfoData {

        var remainingString = "Открыто"

        if let startHour = Int(restaurant.startTime.components(separatedBy: ":")[0]),
           let finishHour = Int(restaurant.finishTime.components(separatedBy: ":")[0]) {

            let currentHour = Calendar.current.component(.hour, from: Date())

            if currentHour < startHour {

                let difference = startHour - currentHour

                remainingString = (difference == 1 ? "Менее " : "") + "\(difference) ч. до открытия"

            } else if currentHour >= finishHour {

                let difference = startHour + (24 - currentHour)

                remainingString = "\(difference) ч. до открытия"
            }
        }

        return RestaurantInfoData(name: restaurant.name,
                                  address: restaurant.address,
                                  buttonType: .able,
                                  image: restaurant.image,
                                  rating: "\(restaurant.rating)".components(separatedBy: ".").joined(separator: ","),
                                  remainingTime: remainingString,
                                  openingTime: [restaurant.startTime, restaurant.finishTime].joined(separator: "-"),
                                  price: "\(restaurant.price) \u{20BD}")
    }

    func restaurantMenuItems(fromCategories categories: [Category]) -> [RestaurantMenuItem] {

        return categories.map {

            RestaurantMenuItem(id: $0.id, name: $0.name, image: nil)
        }
    }

    func favorireMealObject(fromProduct product: Product) -> ProductCellObject {

        return ProductCellObject(id: product.id,
                                 name: product.name,
                                 price: "\(product.price) \u{20BD}",
                                 weight: "\(product.weight) г",
                                 image: product.image,
                                 quantityInCart: product.quantityInCart)
    }

    func favorireMealObjects(fromProducts products: [Product]) -> [ProductCellObject] {

        return products.map { product in

            self.favorireMealObject(fromProduct: product)
        }
    }
}
