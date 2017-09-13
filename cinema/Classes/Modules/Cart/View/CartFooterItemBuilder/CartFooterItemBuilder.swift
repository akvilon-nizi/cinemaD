//
//  CartFooterItemBuilder.swift
//  foodle
//
//  Created by incetro on 18/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import Foundation

// MARK: - CartFooterItemBuilder

protocol CartFooterItemBuilder {

    func cartFooterItem(fromCart cart: Cart) -> CartFooterItem
}
