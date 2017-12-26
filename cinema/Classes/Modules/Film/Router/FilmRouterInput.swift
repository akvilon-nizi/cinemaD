//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol FilmRouterInput: BaseRouterInput {
    func close()
    func home()
    func openStart()
    func openPersonID(_ personID: String, name: String, role: String, persons: [PersonFromFilm])
    func rewiewsFrom(_ film: FullFilm)
}
