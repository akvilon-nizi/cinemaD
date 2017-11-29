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

    func homeTap() {
        router.home()
    }

    func viewIsReady() {
        log.verbose("Film is ready")
        interactor.getInfoFilm(videoID: videoID)
    }

    func backTap() {
        router.close()
    }

    func willWatchTap() {
        interactor.filmWillWatch(videoID: videoID)
    }

    func watchedTap(rate: Int) {
        interactor.filmWatched(videoID: videoID, rate: rate)
    }

    func willWatchTapDelete() {
        interactor.filmWillWatchDelete(videoID: videoID)
    }

    func watchedTapDelete() {
        interactor.filmWatchedDelete(videoID: videoID)
    }

    func openPersonID(_ personID: String, name: String, role: String, persons: [PersonFromFilm]) {
        router.openPersonID(personID, name: name, role: role, persons: persons)
    }
}

// MARK: - FilmInteractorOutput

extension FilmPresenter: FilmInteractorOutput {
    func getError() {
        view.showNetworkError()
    }
    func getFilmInfo(_ filmInfo: FullFilm) {
        view.setFilmInfo(filmInfo)
    }

    func changeStatus() {
        view.statusChange()
    }

    func getRate(_ rate: Double) {
        view.setStatus(rate)
    }
}
