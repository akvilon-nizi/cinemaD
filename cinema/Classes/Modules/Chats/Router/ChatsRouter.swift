//
// Created by Danila Lyahomskiy on 25/12/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class ChatsRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - ChatsRouterInput

extension ChatsRouter: ChatsRouterInput {
    func close() {
        appRouter.backToMain()
    }
}
