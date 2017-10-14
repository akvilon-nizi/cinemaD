//
//  RegistrationUIDResponse.swift
//  cinema
//
//  Created by User on 11.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class RegistrationUIDResponse: ImmutableMappable {

    var token: String

    private let tokenKey = "access_token"

    required init(map: Map) throws {
        token = try map.value(tokenKey)
    }

    func mapping(map: Map) {
        token >>> map[tokenKey]
    }
}
