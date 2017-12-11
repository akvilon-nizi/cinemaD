//
// Created by Danila Lyahomskiy on 05/12/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class FriendsPresenter {

    weak var view: FriendsViewInput!
    var interactor: FriendsInteractorInput!
    var router: FriendsRouterInput!
    weak var output: FriendsModuleOutput?
}

// MARK: - FriendsViewOutput

extension FriendsPresenter: FriendsViewOutput {
    func backTap() {
        router.close()
    }

    func homeTap() {
        router.home()
    }

    func viewIsReady() {
        log.verbose("Friends is ready")
    }
}

// MARK: - FriendsInteractorOutput

extension FriendsPresenter: FriendsInteractorOutput {

}
