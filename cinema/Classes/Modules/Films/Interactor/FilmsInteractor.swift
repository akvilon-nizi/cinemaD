//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import RxMoya
import RxSwift

class FilmsInteractor {

    var provider: RxMoyaProvider<FoodleTarget>!
    fileprivate let disposeBag = DisposeBag()
    weak var output: FilmsInteractorOutput!
}

// MARK: - FilmsInteractorInput

extension FilmsInteractor: FilmsInteractorInput {
    func getAllFilms() {
        provider.requestModel(.films)
            .subscribe { [unowned self] (response: Event<AllFilms>) in
                switch response {
                case let .next(model):
                    self.output.getFilms(films: model.films)
                case let .error(error as ProviderError):
                    if error.status == 403 {
                        self.output.tokenError()
                    } else {
                        self.output.getError()
                    }
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }
}
