//
// Created by akvilon-nizi on 24/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import UIKit

protocol EditingProfileViewInput: class {

    func setupInitialState()

    func getError()
}

protocol EditingProfileViewOutput {

    func viewIsReady()

    func backButtonTap()

    func homeButtonTap()

    func saveAvatar(image: UIImage)
}
