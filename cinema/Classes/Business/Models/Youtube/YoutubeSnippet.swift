//
//  YoutubeSnippet.swift
//  instawish
//
//  Created by Mac on 03.08.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class YoutubeSnippet: ImmutableMappable {

    let title: String
    let thumbnails: YoutubeThumbnails

    private let titleKey = "title"
    private let thumbnailsKey = "thumbnails"

    required init(map: Map) throws {
        title = try map.value(titleKey)
        thumbnails = try map.value(thumbnailsKey)
    }

    func mapping(map: Map) {
        title >>> map[titleKey]
        thumbnails >>> map[thumbnailsKey]
    }
}
