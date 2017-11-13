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
    fileprivate var disposeBag = DisposeBag()
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
                    self.kbData.genresWatched = model.genres
                    self.kbData.yearsWatched = model.years
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
                    self.kbData.genresWillWatch = model.genres
                    self.kbData.yearsWillWatch = model.years
                    self.getCollections()
                case let .error(error as ProviderError):
                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    func getCollections() {
        provider.requestModel(.getCollections)
            .subscribe { [unowned self] (response: Event<GetColResponse>) in
                switch response {
                case let .next(model):
                    self.kbData.collections = model.collections
                    self.output.getData(self.kbData)
                case let .error(error as ProviderError):
                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    func getFilmsIntoCol(idCol: String) {
        provider.requestModel(.getFilmsFromCollections(idCollections: idCol))
            .subscribe { [unowned self] (response: Event<Collection>) in
                switch response {
                case let .next(model):
                    self.output.getCollection(model)
                case let .error(error as ProviderError):
                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    func deleteCollection(idCol: String) {
        provider.requestModel(.deleteCollections(idCollections: idCol))
            .subscribe { [unowned self] (response: Event<FilmResponse>) in
                switch response {
                case let .next(model):
                    print()
                case let .error(error as ProviderError):
                    print()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    func searchFilms(query: String, genres: [String], years: [Int], isWatched: Bool) {
        if isWatched {
            provider.requestModel(.filmWatchedPost(query: query, genres: genres, years: years))
                .subscribe { [unowned self] (response: Event<WatchedResponse>) in
                    switch response {
                    case let .next(model):
                        self.kbData.watched = model.watched
                        self.output.getSearch(self.kbData, isWatched: true)
                    case let .error(error as ProviderError):
                        self.output.getError()
                    default:
                        break
                    }
                }
                .addDisposableTo(disposeBag)
        } else {
            provider.requestModel(.filmWillWatchPost(query: query, genres: genres, years: years))
                .subscribe { [unowned self] (response: Event<WillWatchResponse>) in
                    switch response {
                    case let .next(model):
                        self.kbData.willWatched = model.willWatch
                        self.output.getSearch(self.kbData, isWatched: false)
                    case let .error(error as ProviderError):
                        self.output.getError()
                    default:
                        break
                    }
                }
                .addDisposableTo(disposeBag)
        }

    }
}
