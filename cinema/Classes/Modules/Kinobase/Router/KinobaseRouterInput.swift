//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol KinobaseRouterInput: BaseRouterInput {
    func close()
    func openStart()
    func openAllFilms(_ films: [Film])
    func openCollections(output: NewCollectionsModuleOutput, id: String, name: String, watched: [Film])
    func openFilm(videoId: String, name: String)
    func openAdminCollection(id: String, name: String)
    func openFilter(output: FilterModuleOutput,
    genres: [String],
    years: [Int],
    filterParameters: FilterParameters,
    isWatched: Bool)
}
