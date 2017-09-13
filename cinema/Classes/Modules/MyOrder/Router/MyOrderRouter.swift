//
// Created by DanilaLyahomskiy on 05/09/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class MyOrderRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - MyOrderRouterInput

extension MyOrderRouter: MyOrderRouterInput {
    func close() {
        appRouter.backTransition()
    }
}
