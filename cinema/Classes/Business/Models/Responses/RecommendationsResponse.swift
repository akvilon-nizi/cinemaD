//
//  RecommendationsResponse.swift
//  cinema
//
//  Created by User on 17.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class RecommendationsResponse: ImmutableMappable {

    let recommendations: [Film]

    private let recommendationsKey = "recommendations"

    required init(map: Map) throws {
        recommendations = try map.value(recommendationsKey)
    }

    func mapping(map: Map) {
        recommendations >>> map[recommendationsKey]
    }
}
