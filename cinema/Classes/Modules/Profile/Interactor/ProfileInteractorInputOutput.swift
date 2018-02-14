//
// Created by akvilon-nizi on 23/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol ProfileInteractorInput {
    func getFilms()
    func getProfile()
}

protocol ProfileInteractorOutput: class {
    func getError()
    func tokenError()
    func getWatched(_ films: [FilmCollections])
    func getProfile(_ profile: ProfileModel)
}
