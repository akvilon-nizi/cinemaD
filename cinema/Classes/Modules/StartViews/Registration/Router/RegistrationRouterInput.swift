//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol RegistrationRouterInput: BaseRouterInput {
    func close()
    func transitionToPhone(phone: String, uid: String)
}
