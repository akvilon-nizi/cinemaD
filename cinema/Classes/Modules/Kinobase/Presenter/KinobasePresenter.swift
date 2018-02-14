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
    func tokenError() {
        router.openStart()
    }

    func openAdminCollection(id: String, name: String) {
        router.openAdminCollection(id: id, name: name)
    }

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
        router.openCollections(output: self, id: id, name: name, watched: watched)
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
        var genres: [String] = []
        var years: [Int] = []
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

    func search(query: String, genres: [String], years: [Int], isWatched: Bool) {
        if !query.isEmpty {
            return
        }
        var genres: [String] = []
        var years: [Int] = []
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

    func tapFilter(isWatched: Bool, genres: [String], years: [Int]) {
        self.isWatched = isWatched
        router.openFilter(output: self, genres: genres, years: years, filterParameters: filterParameters, isWatched: isWatched)
    }

    func deleteCollections(id: String) {
        interactor.deleteCollection(idCol: id)
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
        view.startTrober()
        var genres: [String] = []
        var years: [Int] = []
        if isWatched {
            if !genresInds.isEmpty {
                filterParameters.watchedGenres = genresInds
                for ind in genresInds {
                    genres.append(kbData.genresWatched[ind])
                }
            }
            if !yearsInds.isEmpty {
                filterParameters.watchedYears = yearsInds
                for ind in yearsInds {
                    years.append(kbData.yearsWatched[ind])
                }
            }
        } else {
            if !genresInds.isEmpty {
                filterParameters.willWatchGenresIndex = genresInds
                for ind in genresInds {
                    genres.append(kbData.genresWillWatch[ind])
                }
            }
            if !yearsInds.isEmpty {
                filterParameters.willWatchYears = yearsInds
                for ind in yearsInds {
                    years.append(kbData.yearsWillWatch[ind])
                }
            }
        }
        interactor.searchFilms(query: "", genres: genres, years: years, isWatched: isWatched)
    }
}

extension KinobasePresenter: NewCollectionsModuleOutput {
    func reloadData() {
         view.startTrober()
         interactor.getWatched()
    }
}
