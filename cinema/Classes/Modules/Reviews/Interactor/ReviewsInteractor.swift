//
// Created by Danila Lyahomskiy on 28/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import RxMoya
import RxSwift

class ReviewsInteractor {

    weak var output: ReviewsInteractorOutput!
    var provider: RxMoyaProvider<FoodleTarget>!
    fileprivate var disposeBag = DisposeBag()
}

// MARK: - ReviewsInteractorInput

extension ReviewsInteractor: ReviewsInteractorInput {    
    func changeStatusLike(filmID: String, isLiked: Bool, status: Bool) {
        if isLiked {
            if status {
                provider.requestModel(.filmLiked(filmID: filmID))
                    .subscribe { [unowned self] (response: Event<FilmResponse>) in
                        switch response {
                        case let .next(model):
                            if model.message.first == L10n.filmResponseLiked {
                                self.output.changeStatus()
                            } else {
                                self.output.getError()
                            }
                        case let .error(error as ProviderError):
                            self.output.getError()
                        default:
                            break
                        }
                    }
                    .addDisposableTo(disposeBag)
            } else {

            }
        } else {
            if status {
                provider.requestModel(.filmDisLiked(filmID: filmID))
                    .subscribe { [unowned self] (response: Event<FilmResponse>) in
                        switch response {
                        case let .next(model):
                            if model.message.first == L10n.filmResponseDidNotLike {
                                self.output.changeStatus()
                            } else {
                                self.output.getError()
                            }
                        case let .error(error as ProviderError):
                            self.output.getError()
                        default:
                            break
                        }
                    }
                    .addDisposableTo(disposeBag)
            } else {

            }
        }
    }

    func getComment(filmID: String) {
        provider.requestModel(.review(filmID: filmID) )
            .subscribe { [unowned self] (response: Event<ReviewsResponse>) in
                switch response {
                case let .next(model):
                    self.output.getComments(model.reviews)
                case let .error(error as ProviderError):
                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    func putComment(filmID: String, message: String) {
        provider.requestModel(.putReview(filmID: filmID, name: "", description: message))
            .subscribe { [unowned self] (response: Event<Comment>) in
                switch response {
                case let .next(model):
                    self.output.loadComment(model)
                case let .error(error as ProviderError):
                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    func deleteReview(id: String) {
        provider.requestModel(.deleteReview(id: id))
            .subscribe { [unowned self] (response: Event<FilmResponse>) in
                switch response {
                case let .next(model):
                    self.output.deleteComment()
                case let .error(error as ProviderError):
                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }
}
