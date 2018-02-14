//
//  FriendsNewsResponse.swift
//  cinema
//
//  Created by User on 17.12.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class FriendsNewsResponse: ImmutableMappable {

    let friends: [FriendsNews]

    private let friendsKey = "friends"

    required init(map: Map) throws {
        friends = try map.value(friendsKey)
    }

    func mapping(map: Map) {
        friends >>> map[friendsKey]
    }
}
