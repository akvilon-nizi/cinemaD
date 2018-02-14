//
// Created by akvilon-nizi on 23/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import UIKit

protocol ProfileViewInput: class {

    func setupInitialState()

    func getError() 

    func getData(_ films: [FilmCollections])

    func editeProfile(name: String, avatarUrl: String)

    func getProfile(_ profile: ProfileModel)
}

protocol ProfileViewOutput {

    func viewIsReady()

    func backButtonTap()

    func editingButtonTap(nameUser: String, avatar: String)

    func settingButtonTap()

    func openFilm(videoID: String, name: String)

    func openFriends()

    func handleTapRewards()

    func handleTapWatched()

    func refresh()
}
