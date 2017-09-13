//
// Created by incetro on 26/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class EditProfilePresenter {

    weak var view: EditProfileViewInput!
    var interactor: EditProfileInteractorInput!
    var router: EditProfileRouterInput!
    weak var output: EditProfileModuleOutput?

    var profile: Profile

    var newPhone: String?

    init(profile: Profile) {

        self.profile = profile
    }
}

// MARK: - EditProfileViewOutput

extension EditProfilePresenter: EditProfileViewOutput {

    func viewIsReady() {

        log.verbose("EditProfile is ready")
        view.setupInitialState(withProfile: profile)
    }

    func imageWasChosen(image: UIImage) {

        interactor.uploadAvatar(image: image)
    }

    func saveButtonTapped(name: String, phone: String, email: String) {

        if phone != profile.phone {

            newPhone = phone
        }

        profile.name = name
        profile.phone = phone
        profile.email = email

        interactor.updateProfile(profile)
    }

    func needToUpdateProfile() {

        interactor.obtainProfile()
    }

    func leftButtonTapped() {

        router.close()
    }

    func removeAvatarButtonTapped() {

        interactor.removeAvatar()
    }

    func cityButtonTapped() {

        router.openRegion(currentRegion: profile.city)
    }
}

// MARK: - EditProfileInteractorOutput

extension EditProfilePresenter: EditProfileInteractorOutput {

    func removeAvatarSuccess(profile: Profile) {

        self.profile = profile
        view.update(profile: profile)
    }

    func removeAvatarFailure(errorMessage: String) {

        log.error("Finish remove avatar with error: \(errorMessage)")
        router.performTransitionToNetworkAlert(message: errorMessage)
    }

    func uploadAvatarSuccess(profile: Profile) {

        self.profile = profile
        view.update(profile: profile)
    }

    func uploadAvatarFailure(errorMessage: String) {

        log.error("Finish upload avatar with error: \(errorMessage)")
        router.performTransitionToNetworkAlert(message: errorMessage)
    }

    func obtainProfileSuccess(profile: Profile) {

        self.profile = profile
        view.update(profile: profile)
    }

    func obtainProfileFailure(errorMessage: String) {

        log.error("Finish obtain profile with error: \(errorMessage)")
        router.performTransitionToNetworkAlert(message: errorMessage)
    }

    func updateProfileSuccess(profile: Profile) {

        if let phone = newPhone {

            router.openCode(phone: phone)

        } else {

            self.profile = profile
            view.update(profile: profile)
        }
    }

    func updateProfileFailure(errorMessage: String) {

        log.error("Finish update profile with error: \(errorMessage)")
        router.performTransitionToNetworkAlert(message: errorMessage)
    }
}
