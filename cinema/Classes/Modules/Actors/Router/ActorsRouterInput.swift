//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol ActorsRouterInput: BaseRouterInput {
    func close()

    func home()

    func openPersonID(_ personID: String, name: String, role: String, persons: [PersonFromFilm])

    func openFilm(videoId: String, name: String)
}
