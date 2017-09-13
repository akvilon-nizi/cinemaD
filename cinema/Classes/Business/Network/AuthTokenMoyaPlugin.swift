//
// Created by Александр Масленников on 06.08.17.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Moya
import enum Result.Result
import Alamofire

class AuthTokenMoyaPlugin: PluginType {

    static let tag = "AuthTokenMoyaPluginDipTag"

    private let authTokenManager: AuthTokenManagerProtocol

    init(authTokenManager: AuthTokenManagerProtocol) {
        self.authTokenManager = authTokenManager
    }

    func didReceive(_ result: Result<Moya.Response, Moya.MoyaError>, target: TargetType) {
        if case let .success(response) = result, response.statusCode == 401 {
            log.info("Status code: 401 - Remove current api token")
            authTokenManager.removeApiToken()
        }
    }
}
