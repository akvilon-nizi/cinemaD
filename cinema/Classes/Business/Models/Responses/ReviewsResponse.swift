//
//  ReviewsResponse.swift
//  cinema
//
//  Created by iOS on 30.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class ReviewsResponse: ImmutableMappable {

    let reviews: [Comment]

    private let reviewsKey = "reviews"

    required init(map: Map) throws {
        reviews = try map.value(reviewsKey)
    }

    func mapping(map: Map) {
        reviews >>> map[reviewsKey]
    }
}
