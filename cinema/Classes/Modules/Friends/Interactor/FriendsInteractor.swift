//
// Created by Danila Lyahomskiy on 05/12/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import RxMoya
import RxSwift

class FriendsInteractor {

    weak var output: FriendsInteractorOutput!
    var provider: RxMoyaProvider<FoodleTarget>!
}

// MARK: - FriendsInteractorInput

extension FriendsInteractor: FriendsInteractorInput {

}
