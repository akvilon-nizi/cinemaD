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
    var filmID: String!
}

// MARK: - ReviewsViewOutput

extension ReviewsPresenter: ReviewsViewOutput {
    func sendReview(name: String, description: String) {
        interactor.putComment(filmID: filmID, message: description)
    }

    func viewIsReady() {
        log.verbose("Reviews is ready")
        interactor.getComment(filmID: filmID)
    }

    func backTap() {
        router.close()
    }

    func homeTap() {
        router.home()
    }
}

// MARK: - ReviewsInteractorOutput

extension ReviewsPresenter: ReviewsInteractorOutput {
    func getComments(_ comments: [Comment]) {
        view.openComments(comments)
    }

    func loadComment(_ comment: Comment) {
        view.addComment(comment)
    }

    func getError() {
        view.showNetworkError()
    }
}
