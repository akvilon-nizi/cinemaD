//
//  CategoriesResponse.swift
//  cinema
//
//  Created by incetro on 13/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

// MARK: - CategoriesResponse

class CategoriesResponse: ServerResponse {

    var categories: [Category]

    private let categoryKey = "data"

    required init(map: Map) throws {
        categories = try map.value(categoryKey)

        try super.init(map: map)
    }

    override func mapping(map: Map) {
        categories >>> map[categoryKey]

        super.mapping(map: map)
    }
}
