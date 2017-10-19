//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol FilmInteractorInput {
    func getInfoFilm(videoID: String)
}

protocol FilmInteractorOutput: class {
    func getError()
    func getFilmInfo(_ filmInfo: FullFilm)
}
