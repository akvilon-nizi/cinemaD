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
                            self.output.getSeccess()
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
        if filmsAdd.isEmpty {
            deleteFilmsIntoCol(idCol: idCol, filmsID: filmsDelete)
        } else {
            var filmsCol = filmsAdd
            provider.requestModel(.putFilm(idFilm: filmsAdd[0].id, idCollections: idCol))
                .subscribe { [unowned self] (response: Event<FilmResponse>) in
                    switch response {
                    case let .next(model):
                        if model.message.first == L10n.filmResponsePutCollection {
                            filmsCol.remove(at: 0)
                            if filmsCol.isEmpty {
                                if !filmsDelete.isEmpty {
                                    self.deleteFilmsIntoCol(idCol: idCol, filmsID: filmsDelete)
                                } else {
                                    self.output.getSeccess()
                                }
                            } else {
                                self.putDeleteFilms(idCol: idCol, filmsAdd: filmsCol, filmsDelete: filmsDelete)
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
                            self.output.getSeccess()
                        } else {
                            self.deleteFilmsIntoCol(idCol: idCol, filmsID: filmsCol)
                        }
                    } else {
                        self.output.getError()
                    }
                case let .error(error as ProviderError):
//                    self.getFilmsIntoCol(idCol: "String")
                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
//        var request = URLRequest(url: URL(string: String(format: "https://cinemad.pr-solution.ru/api/films/%@/user_collection", "07cdcf7e-95d4-4bb7-b096-cc0d6ecbaf86"))!)
//        request.httpMethod = "DELETE"
//
//        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        request.setValue("eyJhbGciOiJIUzI1NiIsImlhdCI6MTUwOTU0OTY1MywiZXhwIjoxNTA5NjM2MDUzfQ.eyJkZXZpY2UiOiJhcHAiLCJjb3VwbGVfaWQiOiJlYmZkZDgxOC1kZGNlLTQyYWMtYThjZC01N2ViYjcxYjNkNzkiLCJ0eXBlIjoiYWNjZXNzX3Rva2VuIiwiaWQiOiJiMGRhNWJiMC0yYWE4LTQwZTEtYWE1Ni0wYTJiYmNjODg2NDMifQ.ZhNpcamAWjT6X414kgSxa0jAKsbuUmOL7LDE-WmHiWk", forHTTPHeaderField: "Authorization")
//        let dic = ["id": "9ee4b176-f11c-4d97-aa1b-92495675c18a"]
//        guard let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted) else {
//            return
//            // return or break
//        }
//        request.httpBody = dic.description.data(using: String.Encoding.utf8)
//
//                   // request.httpBody = jsonData
//        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
//            guard let data = data, error == nil else {                                                 // check for fundamental networking error
//                print("error=\(error)")
//                //                self?.output?.faulireGetToken()
//                return
//            }
//
//            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
//                print("statusCode should be 200, but is \(httpStatus.statusCode)")
//                print("response = \(response)")
//                print()
//            }
//            guard let json = try? JSONSerialization.jsonObject(with: data)  else {
//                //                self?.output?.faulireGetToken()
//                return
//            }
//            print()
////            if let token: String = json?["access_token"] {
////                //                self?.authTokenManager.save(apiToken: token)
////                //                self?.output?.successGetToken()
////            } else {
////                //                self?.output?.faulireGetToken()
////            }
//
//        }
//        task.resume()
//
//        Alamofire.request(
//            String(format: "https://cinemad.pr-solution.ru/api/films/%@/user_collection", "07cdcf7e-95d4-4bb7-b096-cc0d6ecbaf86"),
//            method: HTTPMethod.head,
//            parameters: ["id": "9ee4b176-f11c-4d97-aa1b-92495675c18a"],
//            encoding: URLEncoding.default,
//            headers: [ "Authorization": "eyJhbGciOiJIUzI1NiIsImlhdCI6MTUwOTU0OTY1MywiZXhwIjoxNTA5NjM2MDUzfQ.eyJkZXZpY2UiOiJhcHAiLCJjb3VwbGVfaWQiOiJlYmZkZDgxOC1kZGNlLTQyYWMtYThjZC01N2ViYjcxYjNkNzkiLCJ0eXBlIjoiYWNjZXNzX3Rva2VuIiwiaWQiOiJiMGRhNWJiMC0yYWE4LTQwZTEtYWE1Ni0wYTJiYmNjODg2NDMifQ.ZhNpcamAWjT6X414kgSxa0jAKsbuUmOL7LDE-WmHiWk", "Content-Type": "application/x-www-form-urlencoded"]
//            )
//            .response(completionHandler: { response in
//                guard let json = try? JSONSerialization.jsonObject(with: response.data!) else {
//                                //                self?.output?.faulireGetToken()
//                                return
//                            }
//                print()
////                print(JSON(data: response.data!))
//            })
    }

//    func deleteFilmsIntoCol(idCol: String, filmsID: [String]) {
//        provider.requestModel(.deleteCollections(idCollections: "f8e8f5b6-a5bf-48b9-858d-fa4e7e626365"))
//            .subscribe { [unowned self] (response: Event<FilmResponse>) in
//                switch response {
//                case let .next(model):
//                    if model.message.first == L10n.filmResponseDeleteCollection {
//                        print()
//                    } else {
//                        print()
//                    }
//                case let .error(error as ProviderError):
//                    self.getFilmsIntoCol(idCol: "String")
//                default:
//                    break
//                }
//            }
//            .addDisposableTo(disposeBag)
//    }
//    func deleteFilmsIntoCol(idCol: String, filmsID: [String]) {
//        provider.requestModel(.deleteFilm(idFilm: "07cdcf7e-95d4-4bb7-b096-cc0d6ecbaf86", idCollections: "f8e8f5b6-a5bf-48b9-858d-fa4e7e626365"))
//            .subscribe { [unowned self] (response: Event<FilmResponse>) in
//                switch response {
//                case let .next(model):
//                    if model.message.first == L10n.filmResponseDeleteCollection {
//                        print()
//                    } else {
//                        print()
//                    }
//                case let .error(error as ProviderError):
//                    self.getFilmsIntoCol(idCol: "String")
//                default:
//                    break
//                }
//            }
//            .addDisposableTo(disposeBag)
//    }

//    GetColResponse

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

}
