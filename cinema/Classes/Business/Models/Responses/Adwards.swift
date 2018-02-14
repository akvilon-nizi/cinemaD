//
//  Adwards.swift
//  cinema
//
//  Created by iOS on 06.12.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class Adwards: ImmutableMappable {

    let awards: [Adward]
    let awardsCount: Int
    let myAwardsCount: Int

    private let awardsKey = "awards"
    private let awardsCountKey = "awards_count"
    private let myAwardsCountKey = "my_awards_count"

    required init(map: Map) throws {
        awards = try map.value(awardsKey)
        awardsCount = try map.value(awardsCountKey)
        myAwardsCount = try map.value(myAwardsCountKey)
    }

    func mapping(map: Map) {
        awards >>> map[awardsKey]
        awardsCount >>> map[awardsCountKey]
        myAwardsCount >>> map[awardsKey]
    }
}
