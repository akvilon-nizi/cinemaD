//
//  NowResponse.swift
//  cinema
//
//  Created by User on 17.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class NowResponse: ImmutableMappable {

    let now: [Film]

    private let nowKey = "now"

    required init(map: Map) throws {
        now = try map.value(nowKey)
    }

    func mapping(map: Map) {
        now >>> map[nowKey]
    }
}
