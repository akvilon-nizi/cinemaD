//
//  YoutubeImage.swift
//  instawish
//
//  Created by Mac on 03.08.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class YoutubeImage: ImmutableMappable {

    let url: String
    let width: Int
    let height: Int

    private let urlKey = "url"
    private let widthKey = "width"
    private let heightKey = "height"

    required init(map: Map) throws {
        url = try map.value(urlKey)
        width = try map.value(widthKey)
        height = try map.value(heightKey)
    }

    func mapping(map: Map) {
        url >>> map[widthKey]
        width >>> map[widthKey]
        height >>> map[heightKey]
    }
}
