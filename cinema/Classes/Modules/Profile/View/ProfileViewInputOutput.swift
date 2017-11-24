//
// Created by akvilon-nizi on 23/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol ProfileViewInput: class {

    func setupInitialState()

    func getError() 

    func getData(_ films: [FilmCollections])
}

protocol ProfileViewOutput {

    func viewIsReady()

    func backButtonTap()

    func editingButtonTap()

    func settingButtonTap()

    func openFilm(videoID: String, name: String)
}
