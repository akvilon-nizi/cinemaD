//
//  NewsResponse.swift
//  cinema
//
//  Created by User on 16.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class NewsResponse: ImmutableMappable {

    let news: [News]

    private let newsKey = "news"

    required init(map: Map) throws {
        news = try map.value(newsKey)
    }

    func mapping(map: Map) {
        news >>> map[newsKey]
    }
}
