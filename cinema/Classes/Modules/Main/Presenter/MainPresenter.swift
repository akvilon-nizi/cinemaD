//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class MainPresenter {

    weak var view: MainViewInput!
    var interactor: MainInteractorInput!
    var router: MainRouterInput!
    weak var output: MainModuleOutput?
}

// MARK: - MainViewOutput

extension MainPresenter: MainViewOutput {

    func viewIsReady() {
        log.verbose("Main is ready")
        interactor.getTrailers()
    }
}

// MARK: - MainInteractorOutput

extension MainPresenter: MainInteractorOutput {

}
