//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol KinobaseViewInput: class {

    func setupInitialState()
    func getError()
    func getData(_ kbData: KinobaseData)
    func getCollection(_ collection: Collection)
    func startTrober()
    func getSearch(_ kbData: KinobaseData, isWatched: Bool)
}

protocol KinobaseViewOutput {

    func viewIsReady()

    func backButtonTap()

    func openFullFilm(_ films: [Film])

    func openCollections(id: String, name: String, watched: [Film])

    func openCollecttion(id: String)

    func openFilm(videoID: String, name: String)

    func refresh()

    func searchWithText(_ query: String, isWatched: Bool)

    func search(query: String, genres: [String], years: [Int], isWatched: Bool)

    func tapFilter(isWatched: Bool, genres: [String], years: [Int])

    func deleteCollections(id: String)

    func openAdminCollection(id: String, name: String)
}
