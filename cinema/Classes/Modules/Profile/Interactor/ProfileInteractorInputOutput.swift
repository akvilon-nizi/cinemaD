//
// Created by incetro on 25/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol ProfileInteractorInput {

    func obtainProfile()

    func logout()

    func turnNotifications(enabled: Bool)
}

protocol ProfileInteractorOutput: class {

    func obtainProfileSuccess(profile: Profile)
    func obtainProfileFailure(errorMessage: String)

    func turnNotificationsSuccess(profile: Profile)
    func turnNotificationsFailure(errorMessage: String)

    func logoutSuccess()
    func logoutFailure(errorMessage: String)
}
