//
// Created by akvilon-nizi on 23/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol ProfileRouterInput: BaseRouterInput {
    func close()

    func openSettings()

    func openEditing(nameUser: String, avatar: String, output: EditingProfileModuleOutput)

    func openFilm(videoId: String, name: String)

    func openFriends()

    func openWatched()

    func openRewards()
}
