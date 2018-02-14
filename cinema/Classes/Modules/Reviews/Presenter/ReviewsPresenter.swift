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
    func setStatusLike(isLike: Bool, isSelect: Bool) {
        view.startChangeStatus()
        interactor.changeStatusLike(filmID: filmID, isLiked: isLike, status: isSelect)
    }

    func deleteReview(id: String) {
        interactor.deleteReview(id: id)
    }

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
    func changeStatus() {
        view.changeStatus()
    }

    func getComments(_ comments: [Comment]) {
        view.openComments(comments)
    }

    func loadComment(_ comment: Comment) {
        view.addComment(comment)
    }

    func getError() {
        view.showNetworkError()
    }

    func deleteComment() {
        view.deleteComment()
    }

    func tokenError() {
        router.openStart()
    }
}
