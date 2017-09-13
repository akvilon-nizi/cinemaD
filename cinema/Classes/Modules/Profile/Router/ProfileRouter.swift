//
// Created by incetro on 25/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class ProfileRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - ProfileRouterInput

extension ProfileRouter: ProfileRouterInput {

    func openEditProfile(output: EditProfileModuleOutput, profile: Profile) {

        appRouter.transition(to: .editProfile(profile: profile, output: output))
    }

    func exit() {

        appRouter.dropAll()
    }

    func openCard(card: Card?) {

    }

    func openMenu() {

        appRouter.backTransition()
    }
}
