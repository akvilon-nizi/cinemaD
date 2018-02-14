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
    var query = ""
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

    func getCollections() {
        provider.requestModel(.getCollections)
            .subscribe { [unowned self] (response: Event<GetColResponse>) in
                switch response {
                case let .next(model):
                    self.kbData.collections = model.collections
                    self.getAdminCollections()
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

    func getFilmsIntoCol(idCol: String) {
        provider.requestModel(.getFilmsFromCollections(idCollections: idCol))
            .subscribe { [unowned self] (response: Event<Collection>) in
                switch response {
                case let .next(model):
                    self.output.getCollection(model)
                case let .error(error as ProviderError):
                    print(error)
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
                    print(model)
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

    func getAdminCollections() {
        provider.requestModel(.getAdminCollections)
            .subscribe { [unowned self] (response: Event<GetColResponse>) in
                switch response {
                case let .next(model):
                    self.kbData.adminCollections = model.collections
                    self.output.getData(self.kbData)
                case let .error(error as ProviderError):
                    print(error)
                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    func searchFilms(query: String, genres: [String], years: [Int], isWatched: Bool) {
         self.query = query
//        provider.manager.session.getAllTasks { tasks in
//            tasks.forEach { $0.cancel() }
//            self.disposeBag = DisposeBag()
//        }
        if query.count >= 1 {
            provider.requestModel(.globalSearch(query: query))
                .subscribe { [unowned self] (response: Event<AllFilms>) in
                    switch response {
                    case let .next(model):
                        if self.query == query {
                            self.kbData.filmsSearch = model.films
                            self.output.getSearch(self.kbData, isWatched: isWatched)
                        }
                    case let .error(error as ProviderError):
                        if error.status == 403 {
                            self.output.tokenError()
                        } else if error.status == 504 {
                            self.searchFilms(query: query, genres: genres, years: years, isWatched: isWatched)
                        } else {
                            self.output.getError()
                        }
                    default:
                        break
                    }
                }
                .addDisposableTo(disposeBag)
        } else {
            disposeBag = DisposeBag()
        }
    }
}
