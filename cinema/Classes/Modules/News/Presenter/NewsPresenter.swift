//
// Created by akvilon-nizi on 16/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class NewsPresenter {

    weak var view: NewsViewInput!
    var interactor: NewsInteractorInput!
    var router: NewsRouterInput!
    weak var output: NewsModuleOutput?
}

// MARK: - NewsViewOutput

extension NewsPresenter: NewsViewOutput {

    func viewIsReady() {
        log.verbose("News is ready")
    }
}

// MARK: - NewsInteractorOutput

extension NewsPresenter: NewsInteractorOutput {

}
