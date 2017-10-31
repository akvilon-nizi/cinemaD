//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol KinobaseViewInput: class {

    func setupInitialState()
    func getError()
    func getData(_ kbData: KinobaseData)
}

protocol KinobaseViewOutput {

    func viewIsReady()

    func backButtonTap()

    func openFullFilm()
}
