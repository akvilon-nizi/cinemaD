//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class FilterParameters {
    var willWatchGenresIndex: [Int] = []
    var willWatchYears: [Int] = []
    var watchedGenres: [Int] = []
    var watchedYears: [Int] = []
}

class KinobasePresenter {

    weak var view: KinobaseViewInput!
    var interactor: KinobaseInteractorInput!
    var router: KinobaseRouterInput!
    weak var output: KinobaseModuleOutput?
    var filterParameters: FilterParameters = FilterParameters()
    var isWatched: Bool = false
    var kbData: KinobaseData = KinobaseData()
}

// MARK: - KinobaseViewOutput

extension KinobasePresenter: KinobaseViewOutput {

    func viewIsReady() {
        log.verbose("Kinobase is ready")
        interactor.getWatched()
    }

    func backButtonTap() {
        router.close()
    }

    func openFullFilm(_ films: [Film]) {
        router.openAllFilms(films)
    }

    func openCollections(id: String, name: String, watched: [Film]) {
        router.openCollections(id: id, name: name, watched: watched)
    }

    func openCollecttion(id: String) {
        interactor.getFilmsIntoCol(idCol: id)
    }

    func openFilm(videoID: String, name: String) {
        router.openFilm(videoId: videoID, name: name)
    }

    func refresh() {
        interactor.getWatched()
    }

    func searchWithText(_ query: String, isWatched: Bool) {
//        if query.isEmpty {
//            return
//        }
        var genres: [String] = []
        var years: [String] = []
        if isWatched {
            if !filterParameters.watchedGenres.isEmpty {
                genres = [kbData.genresWatched[filterParameters.watchedGenres[0]]]
            }
            if !filterParameters.watchedYears.isEmpty {
                years = [kbData.yearsWatched[filterParameters.watchedYears[0]]]
            }
        } else {
            if !filterParameters.willWatchGenresIndex.isEmpty {
                genres = [kbData.genresWillWatch[filterParameters.willWatchGenresIndex[0]]]
            }
            if !filterParameters.willWatchYears.isEmpty {
                years = [kbData.yearsWillWatch[filterParameters.willWatchYears[0]]]
            }
        }
        interactor.searchFilms(query: query, genres: genres, years: years, isWatched: isWatched)
    }

    func search(query: String, genres: [String], years: [String], isWatched: Bool) {
        if !query.isEmpty {
            return
        }
        var genres: [String] = []
        var years: [String] = []
        if isWatched {
            if !filterParameters.watchedGenres.isEmpty {
                genres = [kbData.genresWatched[filterParameters.watchedGenres[0]]]
            }
            if !filterParameters.watchedYears.isEmpty {
                years = [kbData.yearsWatched[filterParameters.watchedYears[0]]]
            }
        } else {
            if !filterParameters.willWatchGenresIndex.isEmpty {
                genres = [kbData.genresWillWatch[filterParameters.willWatchGenresIndex[0]]]
            }
            if !filterParameters.willWatchYears.isEmpty {
                years = [kbData.yearsWillWatch[filterParameters.willWatchYears[0]]]
            }
        }
        interactor.searchFilms(query: query, genres: genres, years: years, isWatched: isWatched)
    }

    func tapFilter(isWatched: Bool, genres: [String], years: [String]) {
        self.isWatched = isWatched
        router.openFilter(output: self, genres: genres, years: years, filterParameters: filterParameters, isWatched: isWatched)
    }
}

// MARK: - KinobaseInteractorOutput

extension KinobasePresenter: KinobaseInteractorOutput {
    func getError() {
        view.getError()
    }
    func getData(_ kbData: KinobaseData) {
        self.kbData = kbData
        view.getData(kbData)
    }
    func getCollection(_ collection: Collection) {
        view.getCollection(collection)
    }

    func getSearch(_ kbData: KinobaseData, isWatched: Bool) {
        view.getSearch(kbData, isWatched: isWatched)
    }
}

extension KinobasePresenter: FilterModuleOutput {
    func setFilters(genresInds: [Int], yearsInds: [Int]) {
        var genres: [String] = []
        var years: [String] = []
        if isWatched {
            if !genresInds.isEmpty {
                filterParameters.watchedGenres = genresInds
                genres = [kbData.genresWatched[genresInds[0]]]
            }
            if !yearsInds.isEmpty {
                filterParameters.watchedYears = yearsInds
               years = [kbData.yearsWatched[yearsInds[0]]]
            }
        } else {
            if !genresInds.isEmpty {
                filterParameters.willWatchGenresIndex = genresInds
                genres = [kbData.genresWillWatch[genresInds[0]]]
            }
            if !yearsInds.isEmpty {
                filterParameters.willWatchYears = yearsInds
                years = [kbData.yearsWillWatch[yearsInds[0]]]
            }
        }
        interactor.searchFilms(query: "", genres: genres, years: years, isWatched: isWatched)
    }
}
