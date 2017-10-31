//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol FilmsViewInput: class {

    func setupInitialState(_ films: [Film])
}

protocol FilmsViewOutput {

    func viewIsReady()

    func backButtonTap()

    func openFilmID(_ filmId: String, name: String)
}
