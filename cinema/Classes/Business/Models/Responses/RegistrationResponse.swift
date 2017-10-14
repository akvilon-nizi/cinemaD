//
//  RegistrationResponse.swift
//  cinema
//
//  Created by User on 10.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class RegistrationResponse: ImmutableMappable {

    var uid: String

    private let uidKey = "uid"

    required init(map: Map) throws {
        uid = try map.value(uidKey)
    }

    func mapping(map: Map) {
        uid >>> map[uidKey]
    }
}
