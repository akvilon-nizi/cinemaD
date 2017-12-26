//
// Created by Danila Lyahomskiy on 05/12/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol FriendsRouterInput: BaseRouterInput {
    func close()

    func home()

    func openStart()

    func openFilm(videoId: String, name: String)
}
