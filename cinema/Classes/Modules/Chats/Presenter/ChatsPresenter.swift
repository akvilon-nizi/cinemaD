//
// Created by Danila Lyahomskiy on 25/12/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class ChatsPresenter {

    weak var view: ChatsViewInput!
    var interactor: ChatsInteractorInput!
    var router: ChatsRouterInput!
    weak var output: ChatsModuleOutput?
}

// MARK: - ChatsViewOutput

extension ChatsPresenter: ChatsViewOutput {
    func backButtonTap() {
        router.close()
    }

    func viewIsReady() {
        log.verbose("Chats is ready")
    }
}

// MARK: - ChatsInteractorOutput

extension ChatsPresenter: ChatsInteractorOutput {

}
