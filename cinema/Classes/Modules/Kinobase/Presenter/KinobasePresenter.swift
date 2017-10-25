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
    }

    func backButtonTap() {
        router.close()
    }
}

// MARK: - KinobaseInteractorOutput

extension KinobasePresenter: KinobaseInteractorOutput {

}
