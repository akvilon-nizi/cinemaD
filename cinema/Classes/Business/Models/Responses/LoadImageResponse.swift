//
//  LoadImageResponse.swift
//  cinema
//
//  Created by iOS on 27.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class LoadImageResponse: ImmutableMappable {

    let url: String

    private let urlKey = "url"

    required init(map: Map) throws {
        url = try map.value(urlKey)
    }

    func mapping(map: Map) {
        url >>> map[urlKey]
    }
}
