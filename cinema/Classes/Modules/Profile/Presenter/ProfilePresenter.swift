//
// Created by akvilon-nizi on 23/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import UIKit

class ProfilePresenter {

    weak var view: ProfileViewInput!
    var interactor: ProfileInteractorInput!
    var router: ProfileRouterInput!
    weak var output: ProfileModuleOutput?
}

// MARK: - ProfileViewOutput

extension ProfilePresenter: ProfileViewOutput {
    func backButtonTap() {
        router.close()
    }

    func editingButtonTap(nameUser: String, avatar: String) {
       router.openEditing(nameUser: nameUser, avatar: avatar, output: self)
    }

    func settingButtonTap() {
       router.openSettings()
    }

    func viewIsReady() {
        log.verbose("Profile is ready")
        interactor.getFilms()
    }

    func openFilm(videoID: String, name: String) {
        router.openFilm(videoId: videoID, name: name)
    }
}

// MARK: - ProfileInteractorOutput

extension ProfilePresenter: ProfileInteractorOutput {
    func getError() {
        view.getError()
    }

    func getWatched(_ films: [FilmCollections]) {
        view.getData(films)
    }
}

// MARK: - EditingProfileModuleOutput

extension ProfilePresenter: EditingProfileModuleOutput {

}
