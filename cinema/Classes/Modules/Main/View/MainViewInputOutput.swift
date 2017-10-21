//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol MainViewInput: class {

    func setupInitialState()

    func getError()

    func getData(_ mainData: MainData)
}

protocol MainViewOutput {

    func viewIsReady()

    func openFilm(videoID: String, name: String)
}
