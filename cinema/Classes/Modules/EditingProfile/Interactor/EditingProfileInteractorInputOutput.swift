//
// Created by akvilon-nizi on 24/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import UIKit

protocol EditingProfileInteractorInput {
    func loadAvatar(image: UIImage)
}

protocol EditingProfileInteractorOutput: class {
    func getError()

    func successEditing()
}
