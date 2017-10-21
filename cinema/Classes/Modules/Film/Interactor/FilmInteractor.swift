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

    func filmWatched(videoID: String, rate: Int) {
        provider.requestModel(.filmWatched(filmID: videoID, rate: rate))
            .subscribe { [unowned self] (response: Event<FilmResponse>) in
                switch response {
                case let .next(model):

                    if model.message.first == L10n.filmResponseWatched {
                        print()
                    } else {
                        print()
                    }
//                    self.output.getFilmInfo(model)
                case let .error(error as ProviderError):
                    print()
//                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    func filmWillWatch(videoID: String) {
        provider.requestModel(.filmWillWatch(filmID: videoID))
            .subscribe { [unowned self] (response: Event<FilmResponse>) in
                switch response {
                case let .next(model):
                    if model.message.first == L10n.filmResponseWillWatch {
                        print()
                    } else {
                        print()
                    }
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
