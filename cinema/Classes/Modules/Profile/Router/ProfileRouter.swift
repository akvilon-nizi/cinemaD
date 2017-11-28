//
// Created by akvilon-nizi on 23/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import UIKit

class ProfileRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - ProfileRouterInput

extension ProfileRouter: ProfileRouterInput {
    func close() {
        appRouter.backTransition()
    }

    func openSettings() {
        appRouter.transition(to: .settings)
    }

    func openEditing(nameUser: String, avatar: String, output: EditingProfileModuleOutput) {
        appRouter.transition(to: .editingProfile(nameUser: nameUser, avatar: avatar, output: output))
    }

    func openFilm(videoId: String, name: String) {
        appRouter.transition(to: .film(videoID: videoId, name: name))
    }
}
