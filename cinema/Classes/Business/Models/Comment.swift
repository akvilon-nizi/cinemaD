//
//  Comment.swift
//  cinema
//
//  Created by User on 22.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class Comment: ImmutableMappable {

    let id: String
    let creator: Creator
    let createdAt: Date
    let description: String
    let shared: Int
    let iSharedIn: [String]

    private let idKey = "id"
    private let creatorKey = "creator"
    private let createdAtKey = "created_at"
    private let descriptionKey = "description"
    private let sharedKey = "shared"
    private let iSharedInKey = "i_shared_in"

    required init(map: Map) throws {
        id = try map.value(idKey)
        creator = try map.value(creatorKey)
        createdAt = try map.value(createdAtKey, using: DateTransform())
        description = try map.value(descriptionKey)
        shared = try map.value(sharedKey)
        iSharedIn = try map.value(iSharedInKey)
    }

    func mapping(map: Map) {
        id >>> map[idKey]
        creator >>> map[creatorKey]
        createdAt >>> (map[createdAtKey], DateTransform())
        description >>> map[descriptionKey]
        shared >>> map[sharedKey]
        iSharedIn >>> map[iSharedInKey]
    }
}
