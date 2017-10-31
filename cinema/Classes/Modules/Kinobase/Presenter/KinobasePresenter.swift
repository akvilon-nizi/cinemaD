//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class KinobasePresenter {

    weak var view: KinobaseViewInput!
    var interactor: KinobaseInteractorInput!
    var router: KinobaseRouterInput!
    weak var output: KinobaseModuleOutput?
}

// MARK: - KinobaseViewOutput

extension KinobasePresenter: KinobaseViewOutput {

    func viewIsReady() {
        log.verbose("Kinobase is ready")
        interactor.getWatched()
    }

    func backButtonTap() {
        router.close()
    }

    func openFullFilm() {
        router.openAllFilms()
    }
}

// MARK: - KinobaseInteractorOutput

extension KinobasePresenter: KinobaseInteractorOutput {
    func getError() {
        view.getError()
    }
    func getData(_ kbData: KinobaseData) {
        view.getData(kbData)
    }
}
