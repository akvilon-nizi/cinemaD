//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol AuthCinemaRouterInput: BaseRouterInput {
    func close()
    func transitionToHelpAuth()
    func transitionToMain()
}
