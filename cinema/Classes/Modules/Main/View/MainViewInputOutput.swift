//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import UIKit

protocol MainViewInput: class {

    func setupInitialState()

    func getError()

    func getData(_ mainData: MainData)

    func getNews(_ mainData: MainData)
}

protocol MainViewOutput {

    func viewIsReady()

    func openFilm(videoID: String, name: String)

    func openKinobase()

    func openRewards()

    func openChats()

    func openTickets()

    func openProfile(mainView: MainTabView)

    func setRootVC(_ rootVC: UINavigationController)

    func changeFilter(_ filters: [String])

    func tapNews(newsID: String)

    func refresh()
}
