//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class FilmsPresenter {

    weak var view: FilmsViewInput!
    var interactor: FilmsInteractorInput!
    var router: FilmsRouterInput!
    weak var output: FilmsModuleOutput?
}

// MARK: - FilmsViewOutput

extension FilmsPresenter: FilmsViewOutput {

    func viewIsReady() {
        log.verbose("Films is ready")
    }
}

// MARK: - FilmsInteractorOutput

extension FilmsPresenter: FilmsInteractorOutput {

}
