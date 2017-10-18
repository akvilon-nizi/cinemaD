//
//  YoutubeItem.swift
//  instawish
//
//  Created by Mac on 03.08.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class YoutubeItem: ImmutableMappable {

    let snippet: YoutubeSnippet

    private let snippetKey = "snippet"

    required init(map: Map) throws {
        snippet = try map.value(snippetKey)
    }

    func mapping(map: Map) {
        snippet >>> map[snippetKey]
    }
}
