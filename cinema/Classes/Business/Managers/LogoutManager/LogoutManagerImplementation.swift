//
//  LogoutManagerImplementation.swift
//  foodle
//
//  Created by incetro on 29/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import Foundation

// MARK: - LogoutManagerImplementation

class LogoutManagerImplementation {

    let regionManager: RegionManager
    let termsManager: TermsManager
    let authTokenManager: AuthTokenManagerProtocol

    init(regionManager: RegionManager, termsManager: TermsManager, authTokenManager: AuthTokenManagerProtocol) {

        self.regionManager = regionManager
        self.termsManager = termsManager
        self.authTokenManager = authTokenManager
    }
}

// MARK: - LogoutManager

extension LogoutManagerImplementation: LogoutManager {

    func clearData() {

        regionManager.clear()
        termsManager.clear()
        authTokenManager.removeApiToken()
    }
}
