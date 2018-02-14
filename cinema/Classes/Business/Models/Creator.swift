//
//  Creator.swift
//  cinema
//
//  Created by User on 16.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class Creator: ImmutableMappable {

    let id: String?
    let avatar: String
    let name: String
    let type: String?

    private let idKey = "id"
    private let avatarKey = "avatar"
    private let nameKey = "name"
    private let typeKey = "type"

    required init(map: Map) throws {
        id = try? map.value(idKey)
        avatar = try map.value(avatarKey)
        name = try map.value(nameKey)
        type = try? map.value(typeKey)
    }

    func mapping(map: Map) {
        id >>> map[idKey]
        avatar >>> map[avatarKey]
        name >>> map[nameKey]
        type >>> map[typeKey]
    }
}
