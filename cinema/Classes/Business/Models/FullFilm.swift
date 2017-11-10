//
//  FullFilm.swift
//  cinema
//
//  Created by User on 17.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class FullFilm: ImmutableMappable {

    let id: String
    let name: String
    let iWatched: Bool
    let iWillWatch: Bool
    let imageUrl: String
    let willWatch: Int
    let gross: Int
    let duration: Int
    let description: String
    let persons: [PersonFromFilm]
    let yearFirstRelease: Int
    let budget: Int
    let rateTmdb: Double
    let ageLimit: Int?
    let adminCollections: [Film]
    let watched: Int
    let genres: [Genre]
    let nameOriginal: String
    let rate: Double
    let myRate: Int

    private let idKey = "id"
    private let nameKey = "name"
    private let iWatchedKey = "i_watched"
    private let iWillWatchKey = "i_will_watch"
    private let imageUrlKey = "image_url"
    private let willWatchKey = "will_watch"
    private let grossKey = "gross"
    private let durationKey = "duration"
    private let descriptionKey = "description"
    private let personsKey = "persons"
    private let yearFirstReleaseKey = "year_first_release"
    private let budgetKey = "budget"
    private let rateTmdbKey = "rate_tmdb"
    private let ageLimitKey = "age_limit"
    private let adminCollectionsKey = "admin_collections"
    private let watchedKey = "watched"
    private let genresKey = "genres"
    private let nameOriginalKey = "name_original"
    private let rateKey = "rate"
    private let myRateKey = "my_rate"

    required init(map: Map) throws {
        id = try map.value(idKey)
        name = try map.value(nameKey)
        iWatched = try map.value(iWatchedKey)
        iWillWatch = try map.value(iWillWatchKey)
        imageUrl = try map.value(imageUrlKey)
        willWatch = try map.value(willWatchKey)
        gross = try map.value(grossKey)
        duration = try map.value(durationKey)
        description = try map.value(descriptionKey)
        persons = try map.value(personsKey)
        yearFirstRelease = try map.value(yearFirstReleaseKey)
        budget = try map.value(budgetKey)
        rateTmdb = try map.value(rateTmdbKey)
        ageLimit = try? map.value(ageLimitKey)
        adminCollections = try map.value(adminCollectionsKey)
        watched = try map.value(watchedKey)
        genres = try map.value(genresKey)
        nameOriginal = try map.value(nameOriginalKey)
        rate = try map.value(rateKey)
        myRate = try map.value(myRateKey)
    }

    func mapping(map: Map) {
        id >>> map[idKey]
        name >>> map[nameKey]
        iWatched >>> map[iWatchedKey]
        iWillWatch >>> map[iWillWatchKey]
        imageUrl >>> map[imageUrlKey]
        willWatch >>> map[willWatchKey]
        gross >>> map[grossKey]
        duration >>> map[durationKey]
        description >>> map[descriptionKey]
        persons >>> map[personsKey]
        yearFirstRelease >>> map[yearFirstReleaseKey]
        budget >>> map[budgetKey]
        description >>> map[descriptionKey]
        rateTmdb >>> map[rateTmdbKey]
        ageLimit >>> map[ageLimitKey]
        adminCollections >>> map[adminCollectionsKey]
        watched >>> map[watchedKey]
        genres >>> map[genresKey]
        nameOriginal >>> map[nameOriginalKey]
        genres >>> map[genresKey]
        nameOriginal >>> map[nameOriginalKey]
        rate >>> map[rateKey]
        myRate >>> map[myRateKey]
    }
}
