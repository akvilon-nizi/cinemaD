//
//  FilmResponse.swift
//  cinema
//
//  Created by Mac on 22.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class FilmResponse: ImmutableMappable {

    let message: String
    let code: Int

    private let messageKey = "message"
    private let codeKey = "status"

    required init(map: Map) throws {
        message = try map.value(messageKey)
        code = try map.value(codeKey)
    }

    func mapping(map: Map) {
        message >>> map[messageKey]
        code >>> map[codeKey]
    }
}
