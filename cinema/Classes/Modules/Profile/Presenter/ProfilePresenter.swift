//
// Created by incetro on 25/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class ProfilePresenter {

    weak var view: ProfileViewInput!
    var interactor: ProfileInteractorInput!
    var router: ProfileRouterInput!
    weak var output: ProfileModuleOutput?

    var profile: Profile? {

        didSet {

            if let profile = profile {

                view.updateProfile(profile)
            }
        }
    }
}

// MARK: - ProfileViewOutput

extension ProfilePresenter: ProfileViewOutput {

    func viewIsReady() {
        log.verbose("Profile is ready")
        view.setupInitialState()
    }

    func notificationsWasSwitched(enabled: Bool) {

        interactor.turnNotifications(enabled: enabled)
    }

    func leftButtonTapped() {

        router.openMenu()
    }

    func editButtonTapped() {

        guard let profile = profile else {

            return
        }

        router.openEditProfile(output: self, profile: profile)
    }

    func exitButtonTapped() {

        interactor.logout()
    }

    func needUpdateProfile() {

        interactor.obtainProfile()
    }

    func addCardButtonTapped() {

        router.openCard(card: nil)
    }

    func cardButtonTapped(card: Card) {

        router.openCard(card: card)
    }
}

// MARK: - EditProfileModuleOutput

extension ProfilePresenter: EditProfileModuleOutput {

    func updateProfile(_ profile: Profile) {

        view.updateProfile(profile)
    }
}

// MARK: - ProfileInteractorOutput

extension ProfilePresenter: ProfileInteractorOutput {

    func logoutSuccess() {

        router.exit()
    }

    func logoutFailure(errorMessage: String) {

        log.error("Finish logout with error: \(errorMessage)")
        router.performTransitionToNetworkAlert(message: errorMessage)
    }

    func turnNotificationsSuccess(profile: Profile) {

        self.profile = profile
    }

    func turnNotificationsFailure(errorMessage: String) {

        log.error("Finish turn notifications with error: \(errorMessage)")
        router.performTransitionToNetworkAlert(message: errorMessage)
    }

    func obtainProfileSuccess(profile: Profile) {

        self.profile = profile
    }

    func obtainProfileFailure(errorMessage: String) {

        log.error("Finish fetch profile with error: \(errorMessage)")
        router.performTransitionToNetworkAlert(message: errorMessage)
    }
}
