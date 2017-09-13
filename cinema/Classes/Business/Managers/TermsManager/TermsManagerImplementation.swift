//
//  TermsManagerImplementation.swift
//  foodle
//
//  Created by incetro on 25/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import Foundation

// MARK: - TermsManagerImplementation

class TermsManagerImplementation {

    fileprivate let termsKey = "UDTermsKey"

    fileprivate let userDefaults: UserDefaults

    init(userDefaults: UserDefaults) {

        self.userDefaults = userDefaults
    }
}

// MARK: - TermsManager

extension TermsManagerImplementation: TermsManager {

    func setConfirmed() {

        userDefaults.set(true, forKey: termsKey)
    }

    func clear() {

        userDefaults.set(nil, forKey: termsKey)
    }

    var confirmed: Bool {

        return userDefaults.bool(forKey: termsKey)
    }
}
