//
//  Sergey500.swift
//  cinema
//
//  Created by iOS on 27.12.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class Sergey500: ImmutableMappable {

    let message: [String]

    private let messageKey = "message"

    required init(map: Map) throws {
        message = try map.value(messageKey)
    }

    func mapping(map: Map) {
        message >>> map[messageKey]
    }
}
