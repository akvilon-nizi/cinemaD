//
// Created by akvilon-nizi on 23/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class ProfilePresenter {

    weak var view: ProfileViewInput!
    var interactor: ProfileInteractorInput!
    var router: ProfileRouterInput!
    weak var output: ProfileModuleOutput?
}

// MARK: - ProfileViewOutput

extension ProfilePresenter: ProfileViewOutput {

    func viewIsReady() {
        log.verbose("Profile is ready")
    }
}

// MARK: - ProfileInteractorOutput

extension ProfilePresenter: ProfileInteractorOutput {

}
