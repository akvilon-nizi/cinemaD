//
// Created by Danila Lyahomskiy on 25/12/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class TicketsRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - TicketsRouterInput

extension TicketsRouter: TicketsRouterInput {
    func close() {
        appRouter.backToMain()
    }
}
