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

    func putNewColWithFilm(name: String, films: [Film]) {
        provider.requestModel(.putCollections(name: name))
            .subscribe { [unowned self] (response: Event<CollectionsResponse>) in
                switch response {
                case let .next(model):
                    self.putFilmsIntoCol(idCol: model.id, films: films)
                case let .error(error as ProviderError):
                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    //1c1bde9e-087b-4552-bc5a-31cebb52ea79 id коллекции
    //07cdcf7e-95d4-4bb7-b096-cc0d6ecbaf86 id фильма
    func putFilmsIntoCol(idCol: String, films: [Film]) {
        var filmsCol = films
        provider.requestModel(.putFilm(idFilm: films[0].id, idCollections: idCol))
            .subscribe { [unowned self] (response: Event<FilmResponse>) in
                switch response {
                case let .next(model):
                    if model.message.first == L10n.filmResponsePutCollection {
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
                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    func putDeleteFilms(idCol: String, filmsAdd: [Film], filmsDelete: [Film]) {
//        if filmsAdd.isEmpty {
//            deleteFilmsIntoCol(idCol: idCol, filmsID: filmsDelete)
//        } else {
//            var filmsCol = filmsAdd
//            provider.requestModel(.putFilm(idFilm: filmsAdd[0].id, idCollections: idCol))
//                .subscribe { [unowned self] (response: Event<FilmResponse>) in
//                    switch response {
//                    case let .next(model):
//                        if model.message.first == L10n.filmResponsePutCollection {
//                            filmsCol.remove(at: 0)
//                            if filmsCol.isEmpty {
//                                if !filmsDelete.isEmpty {
//                                    self.deleteFilmsIntoCol(idCol: idCol, filmsID: filmsDelete)
//                                } else {
//                                    self.output.getSeccess()
//                                }
//                            } else {
//                                self.putDeleteFilms(idCol: idCol, filmsAdd: filmsCol, filmsDelete: filmsDelete)
//                            }
//                        } else {
//                            self.output.getError()
//                        }
//                    case let .error(error as ProviderError):
//                        self.output.getError()
//                    default:
//                        break
//                    }
//                }
//                .addDisposableTo(disposeBag)
//        }
    }

    func deleteFilmsIntoCol(idCol: String, filmsID: [Film]) {
        var filmsCol = filmsID
        provider.requestModel(.deleteFilm(idFilm: filmsID[0].id, idCollections: idCol))
            .subscribe { [unowned self] (response: Event<FilmResponse>) in
                switch response {
                case let .next(model):
                    if model.message.first == L10n.filmResponseDeleteFilmCollection {
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
                    if model.message.first == L10n.collectionsUpdateMessage {
                        self.output.getSeccess(message: L10n.alertCollectionsChange)
                    } else {
                        self.output.getError()
                    }
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
                    self.output.getSeccess(message: L10n.alertCollectionsRemove)
                case let .error(error as ProviderError):
                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }


}
