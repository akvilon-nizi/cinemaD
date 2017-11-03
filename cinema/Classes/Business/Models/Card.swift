//
//  Card.swift
//  cinema
//
//  Created by incetro on 25/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

// MARK: - Card

class Card: ImmutableMappable {

    let id: Int
    let last4: String

    private let idKey = "id"
    private let last4Key = "last4"

    init(id: Int, last4: String) {

        self.id = id
        self.last4 = last4
    }

    required init(map: Map) throws {

        id = try map.value(idKey)
        last4 = try map.value(last4Key)
    }
}
