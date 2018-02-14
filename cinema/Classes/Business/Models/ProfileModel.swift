//
//  ProfileModel.swift
//  cinema
//
//  Created by iOS on 27.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class ProfileModel: ImmutableMappable {

    let id: String
    var name: String
    let watched: Int
    var avatar: String
    let friends: Int
    let rewards: Int
    let phone: String
    let willWatch: Int
    let newMail: Int

    private let idKey = "id"
    private let nameKey = "name"
    private let watchedKey = "watched"
    private let avatarKey = "avatar"
    private let friendsKey = "friends"
    private let rewardsKey = "awards"
    private let phoneKey = "phone"
    private let willWatchKey = "will_watch"
    private let newMailKey = "new_mail"

    required init(map: Map) throws {
        id = try map.value(idKey)
        name = try map.value(nameKey)
        watched = try map.value(watchedKey)
        avatar = try map.value(avatarKey)
        friends = try map.value(friendsKey)
        rewards = try map.value(rewardsKey)
        phone = try map.value(phoneKey)
        willWatch = try map.value(willWatchKey)
        newMail = try map.value(newMailKey)
    }

    func mapping(map: Map) {
        id >>> map[idKey]
        name >>> map[nameKey]
        watched >>> map[watchedKey]
        avatar >>> map[avatarKey]
        friends >>> map[friendsKey]
        rewards >>> map[rewardsKey]
        phone >>> map[phoneKey]
        willWatch >>> map[willWatchKey]
        newMail >>> map[newMailKey]
    }
}
