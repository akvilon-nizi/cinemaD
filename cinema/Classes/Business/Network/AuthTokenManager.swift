//
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import KeychainAccess

protocol AuthTokenManagerProtocol {

    var apiToken: String? { get }

    func save(apiToken: String)

    func removeApiToken()
}

class AuthTokenManager {

    fileprivate let keychain = Keychain()

    fileprivate let apiTokenKey = "ApiTokenKey"
}

// MARK: - AuthTokenManagerProtocol

extension AuthTokenManager: AuthTokenManagerProtocol {

    var apiToken: String? {
        return keychain[apiTokenKey]
    }

    func save(apiToken: String) {
        log.debug("Save api token: \(apiToken)")

        keychain[apiTokenKey] = apiToken
    }

    func removeApiToken() {
        log.debug("Remove api token")

        keychain[apiTokenKey] = nil
    }
}
