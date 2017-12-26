//
// Created by Danila Lyahomskiy on 05/12/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol FriendsInteractorInput {
    func getData()
    func addFriend(id: String)
}

protocol FriendsInteractorOutput: class {
    func getError()
    func getData(data: FriendsData)
    func addedFriend()
    func tokenError()
}
