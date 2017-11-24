//
// Created by akvilon-nizi on 23/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import RxMoya
import RxSwift

class ProfileInteractor {

    weak var output: ProfileInteractorOutput!
    var provider: RxMoyaProvider<FoodleTarget>!
    fileprivate var disposeBag = DisposeBag()
}

// MARK: - ProfileInteractorInput

extension ProfileInteractor: ProfileInteractorInput {
    func getFilms() {
        provider.requestModel(.meFilmWatched)
            .subscribe { [unowned self] (response: Event<WatchedResponse>) in
                switch response {
                case let .next(model):
                    self.output.getWatched(model.watched)
                case let .error(error as ProviderError):
                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }
}
