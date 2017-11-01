//
// Created by akvilon-nizi on 31/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import RxMoya
import RxSwift

class NewCollectionsInteractor {

    weak var output: NewCollectionsInteractorOutput!
    var provider: RxMoyaProvider<FoodleTarget>!
    fileprivate let disposeBag = DisposeBag()

}

// MARK: - NewCollectionsInteractorInput

extension NewCollectionsInteractor: NewCollectionsInteractorInput {
    func getWatched() {
        provider.requestModel(.meFilmWatched)
            .subscribe { [unowned self] (response: Event<WatchedResponse>) in
                switch response {
                case let .next(model):
//                    self.kbData.watched = model.watched
//                    self.getWillWatch()
                    print()
                case let .error(error as ProviderError):
                    print()
//                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }
}
