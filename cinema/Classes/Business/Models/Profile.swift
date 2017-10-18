//
//  Profile.swift
//  cinema
//
//  Created by incetro on 25/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

// MARK: - Profile

class Profile: ImmutableMappable {

    let id: Int
    var name: String
    var avatar: String
    var phone: String
    let needConfirm: Bool
    var email: String
    let promoPoints: Int
    var pushNotifications: Bool
    let cards: [Card]
    var city: Region?

    private let idKey = "id"
    private let nameKey = "name"
    private let avatarKey = "avatar"
    private let phoneKey = "phone"
    private let needConfirmKey = "need_confirm"
    private let emailKey = "email"
    private let promoPointsKey = "promo_points"
    private let pushNotificationsKey = "push_notifications"
    private let cardsKey = "cards"
    private let cityKey = "city"

    required init(map: Map) throws {

        id = try map.value(idKey)
        name = try map.value(nameKey)
        avatar = try map.value(avatarKey)
        phone = try map.value(phoneKey)
        needConfirm = try map.value(needConfirmKey)
        email = try map.value(emailKey)
        promoPoints = try map.value(promoPointsKey)
        pushNotifications = try map.value(pushNotificationsKey)
        cards = try map.value(cardsKey)
        city = try? map.value(cityKey)
    }
}
