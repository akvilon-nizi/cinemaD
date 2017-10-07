//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class FilmPresenter {

    weak var view: FilmViewInput!
    var interactor: FilmInteractorInput!
    var router: FilmRouterInput!
    weak var output: FilmModuleOutput?
}

// MARK: - FilmViewOutput

extension FilmPresenter: FilmViewOutput {

    func viewIsReady() {
        log.verbose("Film is ready")
    }
}

// MARK: - FilmInteractorOutput

extension FilmPresenter: FilmInteractorOutput {

}
