//
//  FriendsNewsResponse.swift
//  cinema
//
//  Created by User on 17.12.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class FriendsNews: Creator {

    let todayAwards: [TodayAwards]
    let todayFriends: [Creator]
    let todayWatched: [Film]
    let todayWillWatch: [Film]

    private let todayAwardsKey = "today_awards"
    private let todayFriendsKey = "today_friends"
    private let todayWatchedKey = "today_watched"
    private let todayWillWatchKey = "today_will_watch"

    required init(map: Map) throws {
        todayAwards = try map.value(todayAwardsKey)
        todayFriends = try map.value(todayFriendsKey)
        todayWatched = try map.value(todayWatchedKey)
        todayWillWatch = try map.value(todayWillWatchKey)

        try super.init(map: map)
    }

    override func mapping(map: Map) {
        todayAwards >>> map[todayAwardsKey]
        todayFriends >>> map[todayFriendsKey]
        todayWatched >>> map[todayWatchedKey]
        todayWillWatch >>> map[todayWillWatchKey]

        super.mapping(map: map)
    }
}
