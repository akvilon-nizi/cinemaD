//
//  YoutubeModel.swift
//  instawish
//
//  Created by Mac on 02.08.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class YoutubeModel: ImmutableMappable {

    let items: [YoutubeItem]

    private let itemsKey = "items"

    required init(map: Map) throws {
        items = try map.value(itemsKey)
    }

    func mapping(map: Map) {
        items >>> map[itemsKey]
    }
}
