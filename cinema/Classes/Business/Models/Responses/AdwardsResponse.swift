//
//  AdwardsResponse.swift
//  cinema
//
//  Created by iOS on 06.12.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class AdwardsResponse: ImmutableMappable {

    var adwards: [String: Adwards] = [:]

    required init(map: Map) throws {
        for (key, value) in map.JSON {
            if let val = value as? [String: Any] {
                let  adw = try Mapper<Adwards>().map(JSON: val)
                adwards[key] = adw
            }
        }
    }

    func mapping(map: Map) {
        for (key, value) in map.JSON {
            adwards[key] >>> map[key]
        }
    }
}
