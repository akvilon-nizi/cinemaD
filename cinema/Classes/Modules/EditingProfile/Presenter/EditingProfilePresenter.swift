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

    func homeButtonTap() {
        router.home()
    }

    func saveAvatar(image: UIImage) {
        interactor.loadAvatar(image: image)
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
    func getError() {
        view.getError()
    }

    func successEditing() {

    }
}
