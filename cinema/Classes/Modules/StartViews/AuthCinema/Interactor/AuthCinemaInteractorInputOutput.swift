//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol AuthCinemaInteractorInput {
    func sendData(password: String, phone: String)
}

protocol AuthCinemaInteractorOutput: class {
    func authSeccess()
    func faulireAuth()
}
