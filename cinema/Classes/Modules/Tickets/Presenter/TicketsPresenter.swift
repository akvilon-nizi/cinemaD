//
// Created by Danila Lyahomskiy on 25/12/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class TicketsPresenter {

    weak var view: TicketsViewInput!
    var interactor: TicketsInteractorInput!
    var router: TicketsRouterInput!
    weak var output: TicketsModuleOutput?
}

// MARK: - TicketsViewOutput

extension TicketsPresenter: TicketsViewOutput {

    func backButtonTap() {
        router.close()
    }

    func viewIsReady() {
        log.verbose("Tickets is ready")
    }
}

// MARK: - TicketsInteractorOutput

extension TicketsPresenter: TicketsInteractorOutput {

}
