//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class KinobaseRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - KinobaseRouterInput

extension KinobaseRouter: KinobaseRouterInput {
    func close() {
        appRouter.backToMain()
    }

    func openAllFilms(_ films: [Film]) {
        appRouter.transition(to: .films(films: films))
    }

    func openCollections(output: NewCollectionsModuleOutput, id: String, name: String, watched: [Film]) {
        appRouter.transition(to: .newCollections(output: output, id: id, name: name, watched: watched))
    }

    func openAdminCollection(id: String, name: String) {
        appRouter.transition(to: .adminCollection(id: id, name: name))
    }

    func openFilm(videoId: String, name: String) {
        appRouter.transition(to: .film(videoID: videoId, name: name))
    }

    func openFilter(output: FilterModuleOutput,
                    genres: [String],
                    years: [Int],
                    filterParameters: FilterParameters,
                    isWatched: Bool) {
        appRouter.transition(to: .filter(output: output,
                                         genres: genres,
                                         years: years,
                                         filterParameters: filterParameters,
                                         isWatched: isWatched
            ))
    }
}
