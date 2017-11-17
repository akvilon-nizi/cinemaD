//
// Created by akvilon-nizi on 16/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class RewardsPresenter {

    weak var view: RewardsViewInput!
    var interactor: RewardsInteractorInput!
    var router: RewardsRouterInput!
    weak var output: RewardsModuleOutput?
}

// MARK: - RewardsViewOutput

extension RewardsPresenter: RewardsViewOutput {

    func viewIsReady() {
        log.verbose("Rewards is ready")
    }
}

// MARK: - RewardsInteractorOutput

extension RewardsPresenter: RewardsInteractorOutput {

}
