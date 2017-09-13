//
// Created by Alexander Maslennikov on 04/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol AuthPhoneViewInput: class {

    func setupInitialState()
}

protocol AuthPhoneViewOutput {

    func viewIsReady()

    func didEndEditing(phone: String)
}
