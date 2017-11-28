//
// Created by Danila Lyahomskiy on 28/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class ReviewsPresenter {

    weak var view: ReviewsViewInput!
    var interactor: ReviewsInteractorInput!
    var router: ReviewsRouterInput!
    weak var output: ReviewsModuleOutput?
}

// MARK: - ReviewsViewOutput

extension ReviewsPresenter: ReviewsViewOutput {

    func viewIsReady() {
        log.verbose("Reviews is ready")
    }
}

// MARK: - ReviewsInteractorOutput

extension ReviewsPresenter: ReviewsInteractorOutput {

}
