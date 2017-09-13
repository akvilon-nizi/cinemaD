//
//  TermsResponse.swift
//  foodle
//
//  Created by incetro on 25/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

// MARK: - TermsResponse

class TermsResponse: ServerResponse {

    let terms: Terms

    private let termsKey = "data"

    required init(map: Map) throws {

        terms = try map.value(termsKey)

        try super.init(map: map)
    }
}
