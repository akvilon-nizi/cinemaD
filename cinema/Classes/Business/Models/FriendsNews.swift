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

    private let todayAwardsKey = "two_weeks_awards"
    private let todayFriendsKey = "two_weeks_friends"
    private let todayWatchedKey = "two_weeks_watched"
    private let todayWillWatchKey = "two_weeks_will_watch"

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
