//
// Created by akvilon-nizi on 31/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol NewCollectionsInteractorInput {
    func putNewColWithFilm(name: String, films: [Film])
    func deleteFilmsIntoCol(idCol: String, filmsID: [Film])
    func putFilmsIntoCol(idCol: String, films: [Film])
    func getFilmsIntoCol(idCol: String)
    func putDeleteFilms(idCol: String, filmsAdd: [Film], filmsDelete: [Film])
}

protocol NewCollectionsInteractorOutput: class {
    func getCollection(collection: Collection)
    func getError()
    func getSeccess()
}
