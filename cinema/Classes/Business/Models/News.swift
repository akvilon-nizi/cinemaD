//
//  News.swift
//  cinema
//
//  Created by User on 16.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class News: ImmutableMappable {

    let id: String
    let name: String
    let type: String
    let creator: Creator
    let createdAt: Date
    let description: String
    let shared: Int
    let iSharedIn: [String]
    let filmId: String?
    let duration: Int?
    let imageUrl: String?
    let typeOfAttached: String?
    let attached: [String]?
    let cover: String?

    private let idKey = "id"
    private let nameKey = "name"
    private let typeKey = "type"
    private let creatorKey = "creator"
    private let createdAtKey = "created_at"
    private let descriptionKey = "description"
    private let sharedKey = "shared"
    private let iSharedInKey = "i_shared_in"
    private let filmIdKey = "film_id"
    private let durationKey = "duration"
    private let imageUrlKey = "image_url"
    private let typeOfAttachedKey = "type_of_attached"
    private let attachedKey = "attached"
    private let coverKey = "cover"

    required init(map: Map) throws {
        id = try map.value(idKey)
        name = try map.value(nameKey)
        type = try map.value(typeKey)
        creator = try map.value(creatorKey)
        createdAt = try map.value(createdAtKey, using: DateTransform())
        description = try map.value(descriptionKey)
        shared = try map.value(sharedKey)
        iSharedIn = try map.value(iSharedInKey)
        filmId = try? map.value(filmIdKey)
        duration = try? map.value(durationKey)
        imageUrl = try? map.value(imageUrlKey)
        typeOfAttached = try? map.value(typeOfAttachedKey)
        attached = try? map.value(attachedKey)
        cover = try? map.value(coverKey)
    }

    func mapping(map: Map) {
        id >>> map[idKey]
        name >>> map[nameKey]
        type >>> map[typeKey]
        creator >>> map[creatorKey]
        createdAt >>> (map[createdAtKey], DateTransform())
        description >>> map[descriptionKey]
        shared >>> map[sharedKey]
        iSharedIn >>> map[iSharedInKey]
        filmId >>> map[filmIdKey]
        duration >>> map[durationKey]
        imageUrl >>> map[imageUrlKey]
        typeOfAttached >>> map[typeOfAttachedKey]
        attached >>> map[attachedKey]
        cover >>> map[coverKey]
    }
}
