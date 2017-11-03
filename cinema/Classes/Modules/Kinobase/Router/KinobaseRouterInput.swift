//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol KinobaseRouterInput: BaseRouterInput {
    func close()
    func openAllFilms(_ films: [Film])
    func openCollections(id: String, name: String, watched: [Film])
    func openFilm(videoId: String, name: String)
}
