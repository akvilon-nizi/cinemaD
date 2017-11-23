//
// Created by akvilon-nizi on 16/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class NewsPresenter {

    weak var view: NewsViewInput!
    var interactor: NewsInteractorInput!
    var router: NewsRouterInput!
    var newsID: String!
    weak var output: NewsModuleOutput?
}

// MARK: - NewsViewOutput

extension NewsPresenter: NewsViewOutput {
    func sendMessage(message: String) {
        interactor.putComment(newsID: newsID, message: message)
    }

    func viewIsReady() {
        log.verbose("News is ready")
        interactor.getNews(newsID: newsID)
    }

    func backButtonTap() {
        router.close()
    }
}

// MARK: - NewsInteractorOutput

extension NewsPresenter: NewsInteractorOutput {
    func loadComment(_ id: String) {
        print()
    }

    func getError() {
        view.showNetworkError()
    }

    func getNews(_ newsData: NewsData) {
        view.openNews(newsData)
    }

}
