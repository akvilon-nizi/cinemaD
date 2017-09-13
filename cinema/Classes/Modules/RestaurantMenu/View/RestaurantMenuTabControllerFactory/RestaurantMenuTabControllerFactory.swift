//
//  RestaurantMenuTabControllerFactory.swift
//  foodle
//
//  Created by incetro on 16/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - RestaurantMenuTabControllerFactory

class RestaurantMenuTabControllerFactory {

    func controllers(from items: [Category]) -> [(viewController: UIViewController, title: String)] {

        return items.map { (item) -> (UIViewController, String) in

            let vc = UIViewController()

            return (vc, item.name)
        }
    }
}
