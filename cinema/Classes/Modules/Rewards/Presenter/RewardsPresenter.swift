//
// Created by akvilon-nizi on 16/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

struct RewardsData {
    var awardsView: [String: Adwards] = [:]
    var awardsGeo: [String: Adwards] = [:]
}

class RewardsPresenter {

    weak var view: RewardsViewInput!
    var interactor: RewardsInteractorInput!
    var router: RewardsRouterInput!
    weak var output: RewardsModuleOutput?
}

// MARK: - RewardsViewOutput

extension RewardsPresenter: RewardsViewOutput {
    func backButtonTap() {
        router.close()
    }

    func viewIsReady() {
        log.verbose("Rewards is ready")
        interactor.getAdwardsView()
    }
}

// MARK: - RewardsInteractorOutput

extension RewardsPresenter: RewardsInteractorOutput {
    func getError() {
        view.showError()
    }

    func getAwards(awards: RewardsData) {
        view.getAwards(awards)
    }
}
