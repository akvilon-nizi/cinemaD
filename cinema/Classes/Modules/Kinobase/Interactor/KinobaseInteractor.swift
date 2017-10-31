//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import RxMoya
import RxSwift

class KinobaseInteractor {

    weak var output: KinobaseInteractorOutput!
    var provider: RxMoyaProvider<FoodleTarget>!
    fileprivate let disposeBag = DisposeBag()
    var kbData = KinobaseData()

}

// MARK: - KinobaseInteractorInput

extension KinobaseInteractor: KinobaseInteractorInput {

    func getWatched() {
        provider.requestModel(.meFilmWatched)
            .subscribe { [unowned self] (response: Event<WatchedResponse>) in
                switch response {
                case let .next(model):
                    self.kbData.watched = model.watched
                    self.getWillWatch()
                case let .error(error as ProviderError):
                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }
    func getWillWatch() {
        provider.requestModel(.meFilmWillWatched)
            .subscribe { [unowned self] (response: Event<WillWatchResponse>) in
                switch response {
                case let .next(model):
                    self.kbData.willWatched = model.willWatch
                    self.output.getData(self.kbData)
                case let .error(error as ProviderError):
                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }
}
