//
//  CartResponse.swift
//  cinema
//
//  Created by incetro on 16/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

// MARK: - CartResponse

class CartResponse: ServerResponse {

    let cart: Cart

    private let cartKey = "data"

    required init(map: Map) throws {

        cart = try map.value(cartKey)

        try super.init(map: map)
    }

    override func mapping(map: Map) {

        cart >>> map[cartKey]

        super.mapping(map: map)
    }
}
