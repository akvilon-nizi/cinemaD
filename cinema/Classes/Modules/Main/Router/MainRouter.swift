//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import UIKit

class MainRouter {

    var appRouter: AppRouterProtocol!
}

// MARK: - MainRouterInput

extension MainRouter: MainRouterInput {
    func openFilm(videoId: String, name: String) {
        appRouter.transition(to: .film(videoID: videoId, name: name))
    }

    func openKinobase() {
        appRouter.transition(to: .kinobase)
    }

    func openRewards() {
        appRouter.transition(to: .rewards)
    }

    func openProfile(mainView: MainTabView) {
        appRouter.transition(to: .profile(mainView: mainView))
    }

    func openStart() {
        appRouter.dropAll()
    }

    func setRootVC(_ rootVC: UINavigationController) {
        appRouter.setRootViewController(viewControler: rootVC)
    }

    func openNews(newsID: String) {
        appRouter.transition(to: .news(newsID: newsID))
    }
}
