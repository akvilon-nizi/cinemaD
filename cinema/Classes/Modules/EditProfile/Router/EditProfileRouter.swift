//
// Created by incetro on 26/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class EditProfileRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - EditProfileRouterInput

extension EditProfileRouter: EditProfileRouterInput {

    func openRegion(currentRegion: Region?) {

        appRouter.transition(to: .region(selectedRegion: currentRegion, needToReturn: true))
    }

    func openCode(phone: String) {

        appRouter.transition(to: .authCode(phone: phone, needToDismiss: true))
    }

    func close() {

        appRouter.backTransition()
    }
}
