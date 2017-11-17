//
// Created by akvilon-nizi on 16/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol NewsInteractorInput {
    func getNews(newsID: String)
}

protocol NewsInteractorOutput: class {
    func getError()

    func getNews(_ news: News)
}
