//
//  RegionManager.swift
//  foodle
//
//  Created by incetro on 24/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import Foundation

// MARK: - RegionManager

protocol RegionManager {

    func save(region: Region)

    func clear()

    var region: Region? { get }
}
