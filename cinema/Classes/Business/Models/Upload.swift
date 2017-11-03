//
//  Upload.swift
//  cinema
//
//  Created by incetro on 28/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

// MARK: - Upload

class Upload: ImmutableMappable {

    let id: Int

    private let idKey = "id"

    required init(map: Map) throws {

        id = try map.value(idKey)
    }
}
