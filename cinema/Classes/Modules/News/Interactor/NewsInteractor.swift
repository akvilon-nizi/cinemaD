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
}

// MARK: - NewsInteractorInput

extension NewsInteractor: NewsInteractorInput {
    func getNews(newsID: String) {
        provider.requestModel(.newsInfo(newsID: newsID) )
            .subscribe { [unowned self] (response: Event<News>) in
                switch response {
                case let .next(model):
                    self.output.getNews(model)
                case let .error(error as ProviderError):                    print()
                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }
}
