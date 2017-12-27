//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import RxMoya
import RxSwift

class FilmInteractor {

    weak var output: FilmInteractorOutput!
    fileprivate var disposeBag = DisposeBag()
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

    func filmWatched(videoID: String, rate: Int) {
        disposeBag = DisposeBag()
        provider.requestModel(.filmWatched(filmID: videoID, rate: rate))
            .subscribe { [unowned self] (response: Event<FilmWatchResponse>) in
                switch response {
                case let .next(model):
                    print(model.rate)
//                    if model.message == L10n.filmResponseWatched {
                        self.output.getRate(model.rate)
//                    } else {
//                        self.output.getError()
//                    }
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

    func filmWillWatch(videoID: String) {
        disposeBag = DisposeBag()
        provider.requestModel(.filmWillWatch(filmID: videoID))
            .subscribe { [unowned self] (response: Event<FilmWatchResponse>) in
                switch response {
                case let .next(model):
                    print()
//                    if model.message == L10n.filmResponseWillWatch {
                        self.output.changeStatus()
//                    } else {
//                        self.output.getError()
//                    }
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

    func filmWatchedDelete(videoID: String) {
        disposeBag = DisposeBag()
        provider.requestModel(.filmWatchedDelete(filmID: videoID))
            .subscribe { [unowned self] (response: Event<FilmResponse>) in
                switch response {
                case let .next(model):
                    if model.message == L10n.filmResponseWatchedDelete {
                        self.output.changeStatus()
                    } else {
                        self.output.getError()
                    }
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

    func filmWillWatchDelete(videoID: String) {
        disposeBag = DisposeBag()
        provider.requestModel(.filmWillWatchDelete(filmID: videoID))
            .subscribe { [unowned self] (response: Event<FilmResponse>) in
                switch response {
                case let .next(model):
                    if model.message == L10n.filmResponseWillWatchDelete {
                        self.output.changeStatus()
                    } else {
                        self.output.getError()
                    }
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
