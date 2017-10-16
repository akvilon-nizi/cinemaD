//
//  ProductsResponse.swift
//  cinema
//
//  Created by incetro on 13/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

// MARK: - ProductsResponse

class ProductsResponse: ServerResponse {

    var products: [Product]

    private let productKey = "data"

    required init(map: Map) throws {
        products = try map.value(productKey)

        try super.init(map: map)
    }

    override func mapping(map: Map) {
        products >>> map[productKey]

        super.mapping(map: map)
    }
}
