//
// Created by Danila Lyahomskiy on 05/12/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol FriendsViewInput: class {

    func setupInitialState()

    func getData(data: FriendsData)

    func addedFriend()

    func showNetworkError()
}

protocol FriendsViewOutput {

    func viewIsReady()

    func refreshData()

    func backTap()

    func homeTap()

    func addFriend(id: String)

    func openFilmId(_ filmID: String, name: String)
}
