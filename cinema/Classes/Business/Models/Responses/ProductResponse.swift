//
//  ProductResponse.swift
//  cinema
//
//  Created by Mac on 04.09.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

// MARK: - ProductResponse

class ProductResponse: ServerResponse {

    var product: Product

    private let productKey = "data"

    required init(map: Map) throws {
        product = try map.value(productKey)

        try super.init(map: map)
    }

    override func mapping(map: Map) {
        product >>> map[productKey]

        super.mapping(map: map)
    }
}
