//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol ActorsViewInput: class {

    func setupInitialState()

    func showNetworkError()

    func getPersonInfo(person: FullPerson)
}

protocol ActorsViewOutput {

    func viewIsReady()

    func backButtonTap()

    func homeButtonTap()

    func openPersonID(_ personID: String, name: String, role: String, persons: [PersonFromFilm])

    func openFilmID(_ filmId: String, name: String)
}
