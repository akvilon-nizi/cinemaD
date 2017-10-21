//
//  FilmResponse.swift
//  cinema
//
//  Created by Mac on 22.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class FilmResponse: ImmutableMappable {

    let message: [String]

    private let messageKey = "message"

    required init(map: Map) throws {
        message = try map.value(messageKey)
    }

    func mapping(map: Map) {
        message >>> map[messageKey]
    }
}
