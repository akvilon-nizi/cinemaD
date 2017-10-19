//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import RxMoya
import RxSwift

class FilmInteractor {

    weak var output: FilmInteractorOutput!
    fileprivate let disposeBag = DisposeBag()
    var provider: RxMoyaProvider<FoodleTarget>!
}

// MARK: - FilmInteractorInput

extension FilmInteractor: FilmInteractorInput {
    func getInfoFilm(videoID: String) {
        provider.requestModel(.film(filmID: videoID))
            .subscribe { [unowned self] (response: Event<FullFilm>) in
                switch response {
                case let .next(model):
                    self.output.getFilmInfo(model)
                case let .error(error as ProviderError):
                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }
}
