//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol FilmsInteractorInput {
    func getAllFilms()
}

protocol FilmsInteractorOutput: class {
    func getError()
    func tokenError()
    func getFilms(films: [Film])
}
