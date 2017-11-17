//
// Created by akvilon-nizi on 16/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class NewsRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - NewsRouterInput

extension NewsRouter: NewsRouterInput {
    func close() {
        appRouter.backTransition()
    }
}
