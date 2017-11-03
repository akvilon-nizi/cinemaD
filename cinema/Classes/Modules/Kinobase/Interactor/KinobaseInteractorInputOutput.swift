//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol KinobaseInteractorInput {
    func getWatched()
}

protocol KinobaseInteractorOutput: class {
    func getError()
    func getData(_ kbData: KinobaseData)
}
