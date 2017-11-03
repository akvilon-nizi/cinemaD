//
//  ProfileResponse.swift
//  cinema
//
//  Created by incetro on 25/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

// MARK: - ProfileResponse

class ProfileResponse: ServerResponse {

    let profile: Profile

    private let profileKey = "data"

    required init(map: Map) throws {

        profile = try map.value(profileKey)

        try super.init(map: map)
    }
}
