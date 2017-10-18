//
//  FirstLaunchManager.swift
//  cinema
//
//  Created by Mac on 30.08.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import KeychainAccess

protocol FirstLaunchManagerProtocol {
    var isNotFirstLaunch: Bool { get set }
}

class FirstLaunchManager: FirstLaunchManagerProtocol {

    private let userDefaults: UserDefaults

    private let firstLaunchKey = "FirstLaunchKey"

    var isNotFirstLaunch: Bool {
        get {
            return userDefaults.bool(forKey: firstLaunchKey)
        }
        set {
            userDefaults.set(newValue, forKey: firstLaunchKey)
        }
    }

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
}
