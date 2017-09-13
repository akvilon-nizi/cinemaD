//
// Created by DanilaLyahomskiy on 01/09/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class CardOfProductRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - CardOfProductRouterInput

extension CardOfProductRouter: CardOfProductRouterInput {
    func close() {
        appRouter.backTransition()
    }
}
