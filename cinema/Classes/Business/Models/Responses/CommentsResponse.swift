//
//  CommentsResponse.swift
//  cinema
//
//  Created by User on 22.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class CommentsResponse: ImmutableMappable {

    let comments: [Comment]

    private let commentsKey = "comments"

    required init(map: Map) throws {
        comments = try map.value(commentsKey)
    }

    func mapping(map: Map) {
        comments >>> map[commentsKey]
    }
}
