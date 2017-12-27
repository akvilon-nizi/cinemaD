//
// Created by Danila Lyahomskiy on 05/12/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

enum FriendsNewsType: String {
    case willWatch = "Будет смотреть:"
    case watched = "Cмотрел:"
    case newFriends = "Добавил друзей:"
    case newAwards = "Получил награды"
}

struct FriendsNewsForView {
    var avatar: String = ""
    var name: String = ""
    var todayAwards: [TodayAwards]
    var todayFriends: [Creator]
    var todayWatched: [Film]
    var todayWillWatch: [Film]
    var type: FriendsNewsType = .watched
}

class FriendsPresenter {

    weak var view: FriendsViewInput!
    var interactor: FriendsInteractorInput!
    var router: FriendsRouterInput!
    weak var output: FriendsModuleOutput?
}

// MARK: - FriendsViewOutput

extension FriendsPresenter: FriendsViewOutput {
    func backTap() {
        router.close()
    }

    func homeTap() {
        router.home()
    }

    func viewIsReady() {
        log.verbose("Friends is ready")
        interactor.getData()
    }

    func addFriend(id: String) {
        interactor.addFriend(id: id)
    }

    func openFilmId(_ filmID: String, name: String) {
        router.openFilm(videoId: filmID, name: name)
    }

    func tokenError() {
        router.openStart()
    }
}

// MARK: - FriendsInteractorOutput

extension FriendsPresenter: FriendsInteractorOutput {
    func getError() {
        view.showNetworkError()
    }

    func getData(data: FriendsData) {
        var dataNews = data
        for news in data.news {
            if !news.todayWatched.isEmpty {
                dataNews.newsView.append(FriendsNewsForView(
                    avatar: news.avatar,
                    name: news.name, todayAwards: [],
                    todayFriends: [],
                    todayWatched: news.todayWatched,
                    todayWillWatch: [],
                    type: .watched))
            }

            if !news.todayWillWatch.isEmpty {
                dataNews.newsView.append(FriendsNewsForView(
                    avatar: news.avatar,
                    name: news.name,
                    todayAwards: [],
                    todayFriends: [],
                    todayWatched: [],
                    todayWillWatch: news.todayWillWatch,
                    type: .willWatch))
            }

            if !news.todayFriends.isEmpty {
                dataNews.newsView.append(FriendsNewsForView(
                    avatar: news.avatar,
                    name: news.name,
                    todayAwards: [],
                    todayFriends: news.todayFriends,
                    todayWatched: [],
                    todayWillWatch: [],
                    type: .newFriends))
            }

            if !news.todayAwards.isEmpty {
                dataNews.newsView.append(FriendsNewsForView(
                    avatar: news.avatar,
                    name: news.name,
                    todayAwards: news.todayAwards,
                    todayFriends: [],
                    todayWatched: [],
                    todayWillWatch: [],
                    type: .newAwards))
            }
        }
        view.getData(data: dataNews)
    }

    func addedFriend() {
        view.addedFriend()
    }
}
