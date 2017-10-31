//
//  AllFilms.swift
//  cinema
//
//  Created by Mac on 31.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class AllFilms: ImmutableMappable {

    let films: [Film]

    private let filmsKey = "films"

    required init(map: Map) throws {
        films = try map.value(filmsKey)
    }

    func mapping(map: Map) {
        films >>> map[filmsKey]
    }
}
