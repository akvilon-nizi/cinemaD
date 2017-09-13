//
//  RegionManagerImplementation.swift
//  foodle
//
//  Created by incetro on 24/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

// MARK: - RegionManagerImplementation

class RegionManagerImplementation {

    fileprivate let regionKey = "UDRegionKey"

    fileprivate let userDefaults: UserDefaults

    init(userDefaults: UserDefaults) {

        self.userDefaults = userDefaults
    }
}

// MARK: - RegionManager

extension RegionManagerImplementation: RegionManager {

    func save(region: Region) {

        guard let json = Mapper<Region>().toJSONString(region) else {

            return
        }

        userDefaults.set(json, forKey: regionKey)
    }

    func clear() {

        userDefaults.set(nil, forKey: regionKey)
    }

    var region: Region? {

        if let json = userDefaults.string(forKey: regionKey) {

            let region = try? Mapper<Region>().map(JSONString: json)

            return region
        }

        return nil
    }
}
