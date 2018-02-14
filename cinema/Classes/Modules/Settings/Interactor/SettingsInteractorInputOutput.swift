//
// Created by akvilon-nizi on 23/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol SettingsInteractorInput {
    func logout()
}

protocol SettingsInteractorOutput: class {
    func getError()
    func successLogout()
    func tokenError()
}
