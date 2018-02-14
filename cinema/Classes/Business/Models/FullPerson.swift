//
//  FullPerson.swift
//  cinema
//
//  Created by User on 17.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class FullPerson: ImmutableMappable {

    let id: String
    let name: String
    let birthday: Date?
    let deathday: Date?
    let films: [FilmFromPerson]
    let imageUrl: String?
    let description: String?
    let birthPlace: String?

    private let idKey = "id"
    private let nameKey = "name"
    private let birthdayKey = "birthday"
    private let birthPlaceKey = "birth_place"
    private let filmsKey = "films"
    private let imageUrlKey = "image_url"
    private let descriptionKey = "description"
    private let deathdayKey = "deathday"

    required init(map: Map) throws {
        id = try map.value(idKey)
        name = try map.value(nameKey)
        birthday = try? map.value(birthdayKey, using: DateTransform())
        films = try map.value(filmsKey)
        imageUrl = try? map.value(imageUrlKey)
        description = try? map.value(descriptionKey)
        birthPlace = try? map.value(birthPlaceKey)
        deathday = try? map.value(deathdayKey, using: DateTransform())
    }

    func mapping(map: Map) {
        id >>> map[idKey]
        name >>> map[nameKey]
        birthday >>> (map[birthdayKey], DateTransform())
        films >>> map[filmsKey]
        imageUrl >>> map[imageUrlKey]
        description >>> map[descriptionKey]
        birthPlace >>> map[birthPlaceKey]
        deathday >>> (map[deathdayKey], DateTransform())
    }
}
