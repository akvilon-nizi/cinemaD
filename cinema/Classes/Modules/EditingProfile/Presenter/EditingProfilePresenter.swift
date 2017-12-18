//
// Created by akvilon-nizi on 24/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import UIKit

class EditingProfilePresenter {

    weak var view: EditingProfileViewInput!
    var interactor: EditingProfileInteractorInput!
    var router: EditingProfileRouterInput!
    weak var output: EditingProfileModuleOutput?
}

// MARK: - EditingProfileViewOutput

extension EditingProfilePresenter: EditingProfileViewOutput {
    func saveEditing(image: UIImage?, name: String, oldPassword: String, password: String) {
        interactor.editeProfile(image: image, name: name, oldPassword: oldPassword, password: password)
    }

    func homeButtonTap() {
        router.home()
    }

    func viewIsReady() {
        log.verbose("EditingProfile is ready")
    }

    func backButtonTap() {
        router.close()
    }
}

// MARK: - EditingProfileInteractorOutput

extension EditingProfilePresenter: EditingProfileInteractorOutput {
    func successEditing(_ profile: ProfileModel) {

        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.profile = profile
        }

        output?.editeProfile(name: profile.name, imageUrl: profile.avatar)

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.changeProfileAvatar), object: nil, userInfo: ["imageUrl": profile.avatar])

        router.close()
    }

    func getError() {
        view.getError()
    }
}
