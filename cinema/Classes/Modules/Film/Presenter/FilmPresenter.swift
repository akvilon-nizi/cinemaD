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
    let videoID: String

    init(videoID: String) {
        self.videoID = videoID
    }
}

// MARK: - FilmViewOutput

extension FilmPresenter: FilmViewOutput {

    func viewIsReady() {
        log.verbose("Film is ready")
        interactor.getInfoFilm(videoID: videoID)
    }

    func backTap() {
        router.close()
    }
}

// MARK: - FilmInteractorOutput

extension FilmPresenter: FilmInteractorOutput {
    func getError() {
        
    }
    func getFilmInfo(_ filmInfo: FullFilm) {
        view.setFilmInfo(filmInfo)
    }
}
