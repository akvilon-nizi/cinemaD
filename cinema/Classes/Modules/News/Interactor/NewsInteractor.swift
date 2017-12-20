//
// Created by akvilon-nizi on 16/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import RxMoya
import RxSwift

class NewsInteractor {

    weak var output: NewsInteractorOutput!
    fileprivate var disposeBag = DisposeBag()
    var provider: RxMoyaProvider<FoodleTarget>!
    var newsData = NewsData()
}

// MARK: - NewsInteractorInput

extension NewsInteractor: NewsInteractorInput {
    func getNews(newsID: String) {
        provider.requestModel(.newsInfo(newsID: newsID) )
            .subscribe { [unowned self] (response: Event<News>) in
                switch response {
                case let .next(model):
                    self.newsData.news = model
                    self.getComment(newsID: newsID)
                case let .error(error as ProviderError):
                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    func getComment(newsID: String) {
        provider.requestModel(.newsComments(newsID: newsID) )
            .subscribe { [unowned self] (response: Event<CommentsResponse>) in
                switch response {
                case let .next(model):
                    self.newsData.comments = model.comments
                    self.output.getNews(self.newsData)
                case let .error(error as ProviderError):
                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    func putComment(newsID: String, message: String) {
        provider.requestModel(.putNewsComment(newsID: newsID, message: message) )
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

    func deleteComment(id: String) {
        provider.requestModel(.deleteComment(id: id))
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
