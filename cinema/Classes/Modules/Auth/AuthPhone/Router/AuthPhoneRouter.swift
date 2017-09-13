//
// Created by Alexander Maslennikov on 04/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class AuthPhoneRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - AuthPhoneRouterInput

extension AuthPhoneRouter: AuthPhoneRouterInput {

    func preformTransitionToRestaurantsModule() {
        appRouter.transition(to: .restaurants)
    }

    func openAuthCode(withPhone phone: String) {

        appRouter.transition(to: .authCode(phone: phone, needToDismiss: false))
    }
}
