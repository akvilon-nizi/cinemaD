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
    let birthday: String?
    let films: [FilmFromPerson]
    let imageUrl: String?
    let description: String?
    let birthPlace: String?

    private let idKey = "id"
    private let nameKey = "name"
    private let birthdayKey = "birthday"
    private let filmsKey = "films"
    private let imageUrlKey = "image_url"
    private let descriptionKey = "description"
    private let birthPlaceKey = "birth_place"

    required init(map: Map) throws {
        id = try map.value(idKey)
        name = try map.value(nameKey)
        birthday = try? map.value(birthdayKey)
        films = try map.value(filmsKey)
        imageUrl = try? map.value(imageUrlKey)
        description = try? map.value(descriptionKey)
        birthPlace = try? map.value(birthPlaceKey)
    }

    func mapping(map: Map) {
        id >>> map[idKey]
        name >>> map[nameKey]
        birthday >>> map[birthdayKey]
        films >>> map[filmsKey]
        imageUrl >>> map[imageUrlKey]
        description >>> map[descriptionKey]
        birthPlace >>> map[birthPlaceKey]
    }
}
