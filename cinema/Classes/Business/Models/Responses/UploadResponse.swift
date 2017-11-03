//
//  UploadResponse.swift
//  cinema
//
//  Created by incetro on 28/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

// MARK: - UploadResponse

class UploadResponse: ServerResponse {

    let upload: Upload

    private let uploadKey = "data"

    required init(map: Map) throws {

        upload = try map.value(uploadKey)

        try super.init(map: map)
    }
}
