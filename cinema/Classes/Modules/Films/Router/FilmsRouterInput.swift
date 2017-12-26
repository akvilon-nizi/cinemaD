//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol FilmsRouterInput: BaseRouterInput {
    func close()

    func home()
    func openStart()
    func openFilm(videoId: String, name: String)
}
