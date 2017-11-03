//
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class AuthCheckCodeResponse: ServerResponse {

    var token: String

    private let tokenKey = "data.token"

    required init(map: Map) throws {
        token = try map.value(tokenKey)

        try super.init(map: map)
    }

    override func mapping(map: Map) {
        token >>> map[tokenKey]

        super.mapping(map: map)
    }
}
