//
//  YoutubeThumbnails.swift
//  instawish
//
//  Created by Mac on 03.08.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class YoutubeThumbnails: ImmutableMappable {

    let standard: YoutubeImage?
    let high: YoutubeImage?
    let maxres: YoutubeImage?
    let medium: YoutubeImage?
    let defaultImage: YoutubeImage?

    private let standardKey = "standard"
    private let highKey = "high"
    private let maxresKey = "maxres"
    private let mediumKey = "medium"
    private let defaultKey = "default"

    required init(map: Map) throws {
        standard = try? map.value(standardKey)
        high = try? map.value(highKey)
        maxres = try? map.value(maxresKey)
        medium = try? map.value(mediumKey)
        defaultImage = try? map.value(defaultKey)
    }

    func mapping(map: Map) {
        standard >>> map[standardKey]
        high >>> map[highKey]
        maxres >>> map[maxresKey]
        medium >>> map[mediumKey]
        defaultImage >>> map[defaultKey]
    }
}
