//
//  GetColResponse.swift
//  cinema
//
//  Created by User on 01.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class GetColResponse: ImmutableMappable {

    var collections: [Collection]

    private let collectionsKey = "collections"

    required init(map: Map) throws {
        collections = try map.value(collectionsKey)
    }

    func mapping(map: Map) {
        collections >>> map[collectionsKey]
    }
}
