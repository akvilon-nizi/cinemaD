//
//  CollectionsResponse.swift
//  cinema
//
//  Created by User on 01.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class CollectionsResponse: ImmutableMappable {

    var id: String

    private let idKey = "id"

    required init(map: Map) throws {
        id = try map.value(idKey)
    }

    func mapping(map: Map) {
        id >>> map[idKey]
    }
}
