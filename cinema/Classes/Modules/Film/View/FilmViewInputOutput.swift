//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol FilmViewInput: class {

    func setupInitialState()

    func setFilmInfo(_ filmInfo: FullFilm)

    func showNetworkError()

    func statusChange()

    func setStatus(_ rate: Double)

}

protocol FilmViewOutput {

    func viewIsReady()

    func backTap()

    func willWatchTap()

    func watchedTap(rate: Int)

    func willWatchTapDelete()

    func watchedTapDelete()
}
