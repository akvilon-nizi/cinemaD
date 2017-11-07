//
// Created by 1 on 07/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class FilterPresenter {

    weak var view: FilterViewInput!
    var interactor: FilterInteractorInput!
    var router: FilterRouterInput!
    weak var output: FilterModuleOutput?
}

// MARK: - FilterViewOutput

extension FilterPresenter: FilterViewOutput {

    func viewIsReady() {
        log.verbose("Filter is ready")
    }
}

// MARK: - FilterInteractorOutput

extension FilterPresenter: FilterInteractorOutput {

}
