//
// Created by akvilon-nizi on 16/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol RewardsInteractorInput {
    func getAdwardsView()
}

protocol RewardsInteractorOutput: class {
    func getError()
    func getAwards(awards: RewardsData)
}
