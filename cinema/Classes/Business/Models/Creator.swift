//
//  Creator.swift
//  cinema
//
//  Created by User on 16.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class Creator: ImmutableMappable {

    let avatar: String
    let name: String

    private let avatarKey = "avatar"
    private let nameKey = "name"

    required init(map: Map) throws {
        avatar = try map.value(avatarKey)
        name = try map.value(nameKey)
    }

    func mapping(map: Map) {
        avatar >>> map[avatarKey]
        name >>> map[nameKey]
    }
}
