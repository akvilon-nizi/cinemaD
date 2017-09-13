//
// Created by incetro on 25/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol ProfileRouterInput: BaseRouterInput {

    func openEditProfile(output: EditProfileModuleOutput, profile: Profile)

    func openCard(card: Card?)

    func openMenu()

    func exit()
}
