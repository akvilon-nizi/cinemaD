//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import UIKit

class MainPresenter {

    weak var view: MainViewInput!
    var interactor: MainInteractorInput!
    var router: MainRouterInput!
    weak var output: MainModuleOutput?
}

// MARK: - MainViewOutput

extension MainPresenter: MainViewOutput {
    func setRootVC(_ rootVC: UINavigationController) {
        router.setRootVC(rootVC)
    }

    func viewIsReady() {
        log.verbose("Main is ready")
        interactor.getData()
    }

    func openFilm(videoID: String, name: String) {
        router.openFilm(videoId: videoID, name: name)
    }

    func openKinobase() {
        router.openKinobase()
    }

}

// MARK: - MainInteractorOutput

extension MainPresenter: MainInteractorOutput {
    func tokenError() {
        router.openStart()
    }

    func getError() {
        view.getError()
    }
    func getData(mainData: MainData) {
        view.getData(mainData)
    }
}
