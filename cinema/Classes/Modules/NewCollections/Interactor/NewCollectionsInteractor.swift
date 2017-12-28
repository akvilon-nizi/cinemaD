//
// Created by akvilon-nizi on 31/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import RxMoya
import RxSwift
import Alamofire

class NewCollectionsInteractor {

    weak var output: NewCollectionsInteractorOutput!
    var provider: RxMoyaProvider<FoodleTarget>!
    fileprivate var disposeBag = DisposeBag()

}

// MARK: - NewCollectionsInteractorInput

extension NewCollectionsInteractor: NewCollectionsInteractorInput {

    func getFilms(_ text: String) {
        disposeBag = DisposeBag()
        if text != "" {
            provider.requestModel(.globalSearch(query: text) )
                .subscribe { [unowned self] (response: Event<AllFilms>) in
                    switch response {
                    case let .next(model):
                        self.output.getFilms(model.films)
                    case let .error(error as ProviderError):
                        if error.status == 403 {
                            self.output.tokenError()
                        } else if error.status == 504 {
                            self.getFilms(text)
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

    func putNewColWithFilm(name: String, films: [Film]) {
        provider.requestModel(.putCollections(name: name))
            .subscribe { [unowned self] (response: Event<CollectionsResponse>) in
                switch response {
                case let .next(model):
                    self.putFilmsIntoCol(idCol: model.id, films: films)
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

    func putFilmsIntoCol(idCol: String, films: [Film]) {
        var filmsCol = films
        provider.requestModel(.putFilm(idFilm: films[0].id, idCollections: idCol))
            .subscribe { [unowned self] (response: Event<FilmResponse>) in
                switch response {
                case let .next(model):
                    if model.message == L10n.filmResponsePutCollection {
                        filmsCol.remove(at: 0)
                        if filmsCol.isEmpty {
                            self.output.getSeccess(message: L10n.alertCollectionsAdd)
                        } else {
                            self.putFilmsIntoCol(idCol: idCol, films: filmsCol)
                        }
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

    func deleteFilmsIntoCol(idCol: String, filmsID: [Film]) {
        var filmsCol = filmsID
        provider.requestModel(.deleteFilm(idFilm: filmsID[0].id, idCollections: idCol))
            .subscribe { [unowned self] (response: Event<FilmResponse>) in
                switch response {
                case let .next(model):
                    if model.message == L10n.filmResponseDeleteFilmCollection {
                        filmsCol.remove(at: 0)
                        if filmsCol.isEmpty {
                            self.output.getSeccess(message: L10n.alertCollectionsRemove)
                        } else {
                            self.deleteFilmsIntoCol(idCol: idCol, filmsID: filmsCol)
                        }
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

    func getFilmsIntoCol(idCol: String) {
        provider.requestModel(.getFilmsFromCollections(idCollections: idCol))
            .subscribe { [unowned self] (response: Event<Collection>) in
                switch response {
                case let .next(model):
                    self.output.getCollection(collection: model)
                case let .error(error as ProviderError):
                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    func patchCollections(idCol: String, name: String, filmsId: [String]) {
        provider.requestModel(.patchCollections(idCol: idCol, name: name, filmsID: filmsId))
            .subscribe { [unowned self] (response: Event<FilmResponse>) in
                switch response {
                case let .next(model):
                    if model.message == L10n.collectionsUpdateMessage {
                        self.output.getSeccess(message: L10n.alertCollectionsChange)
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

    func deleteCollection(idCol: String) {
        provider.requestModel(.deleteCollections(idCollections: idCol))
            .subscribe { [unowned self] (response: Event<FilmResponse>) in
                switch response {
                case let .next(model):
                    self.output.getSeccess(message: L10n.alertCollectionsRemove)
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
