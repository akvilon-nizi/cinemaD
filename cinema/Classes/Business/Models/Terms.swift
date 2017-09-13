//
//  Terms.swift
//  foodle
//
//  Created by incetro on 25/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

// MARK: - Terms

class Terms: ImmutableMappable {

    let text: String

    private let textKey = "text"

    required init(map: Map) throws {

        text = try map.value(textKey)
    }
}
