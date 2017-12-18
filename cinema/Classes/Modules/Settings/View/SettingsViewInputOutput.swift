//
// Created by akvilon-nizi on 23/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol SettingsViewInput: class {

    func setupInitialState()
}

protocol SettingsViewOutput {

    func viewIsReady()

    func backButtonTap()

    func saveButtonTap(_ isLocation: Bool)
}
