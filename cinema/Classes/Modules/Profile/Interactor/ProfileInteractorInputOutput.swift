//
// Created by akvilon-nizi on 23/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol ProfileInteractorInput {
    func getFilms()
}

protocol ProfileInteractorOutput: class {
    func getError()
    func getWatched(_ films: [FilmCollections])
}
