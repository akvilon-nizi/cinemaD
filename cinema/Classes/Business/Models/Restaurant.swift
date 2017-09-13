//
// Created by Александр Масленников on 08.08.17.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class Restaurant: ImmutableMappable {

    let id: Int
    let lat: Double
    let long: Double
    let name: String
    let image: String
    let address: String
    let rating: Double
    let distance: Double?

    private let idKey = "id"
    private let latKey = "lat"
    private let longKey = "long"
    private let nameKey = "name"
    private let imageKey = "image"
    private let addressKey = "address"
    private let ratingKey = "rating"
    private let distanceKey = "distance"

    required init(map: Map) throws {
        id = try map.value(idKey)
        lat = try map.value(latKey)
        long = try map.value(longKey)
        name = try map.value(nameKey)
        image = try map.value(imageKey)
        address = try map.value(addressKey)
        rating = try map.value(ratingKey)
        distance = try? map.value(distanceKey)
    }

    func mapping(map: Map) {
        id >>> map[idKey]
        lat >>> map[latKey]
        long >>> map[longKey]
        name >>> map[nameKey]
        image >>> map[imageKey]
        address >>> map[addressKey]
        rating >>> map[ratingKey]
        distance >>> map[distanceKey]
    }
}
