//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import UIKit

protocol MainRouterInput: BaseRouterInput {
    func openFilm(videoId: String, name: String)
    func openKinobase()
    func openRewards()
    func openStart()
    func openProfile(mainView: MainTabView)
    func setRootVC(_ rootVC: UINavigationController)
    func openNews(newsID: String)
    func openChats()
    func openTickets()
}
