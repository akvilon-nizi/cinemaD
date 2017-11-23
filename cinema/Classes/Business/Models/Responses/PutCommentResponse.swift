//
//  PutComment.swift
//  cinema
//
//  Created by User on 22.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class PutCommentResponse: ImmutableMappable {

    var id: String

    private let idKey = "id"

    required init(map: Map) throws {
        id = try map.value(idKey)
    }

    func mapping(map: Map) {
        id >>> map[idKey]
    }
}
