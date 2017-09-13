//
// Created by incetro on 26/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol EditProfileRouterInput: BaseRouterInput {

    func openRegion(currentRegion: Region?)

    func openCode(phone: String)

    func close()
}
