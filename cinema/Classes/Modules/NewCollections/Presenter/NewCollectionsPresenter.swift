//
// Created by akvilon-nizi on 31/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class NewCollectionsPresenter {

    weak var view: NewCollectionsViewInput!
    var interactor: NewCollectionsInteractorInput!
    var router: NewCollectionsRouterInput!
    var id: String!
    weak var output: NewCollectionsModuleOutput?
}

// MARK: - NewCollectionsViewOutput

extension NewCollectionsPresenter: NewCollectionsViewOutput {

    func viewIsReady() {
        log.verbose("NewCollections is ready")
//        interactor.putNewColWithFilm(name: "Советские", filmsID: ["sd", "a"])
        if id.isEmpty {
            view.setCollections(collections: [])
        } else {
            interactor.getFilmsIntoCol(idCol: id)
        }
    }

    func backButtonTap() {
        router.close()
    }

    func addNewFilm(name: String, films: [Film]) {
        interactor.putNewColWithFilm(name: name, films: films)
    }
}

// MARK: - NewCollectionsInteractorOutput

extension NewCollectionsPresenter: NewCollectionsInteractorOutput {
    func getCollection(collection: Collection) {
        var colFilms: [Film] = []
        if let colFilmsArray = collection.films {
            for filmColW in colFilmsArray {
                let film = Film(id: filmColW.id, name: filmColW.name, imageUrl: filmColW.imageUrl)
                colFilms.append(film)
            }
        }
        view.setCollections(collections: colFilms)
    }
    func getError() {
        view.getError()
    }

    func getSeccess() {
        router.close()
        view.getSeccess()
    }
}
