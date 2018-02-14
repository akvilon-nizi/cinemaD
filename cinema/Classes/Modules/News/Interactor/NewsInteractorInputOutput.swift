//
// Created by akvilon-nizi on 16/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol NewsInteractorInput {
    func getNews(newsID: String)
    func putComment(newsID: String, message: String)
    func getComment(newsID: String)
    func deleteComment(id: String)
}

protocol NewsInteractorOutput: class {
    func getError()
    func tokenError()
    func getNews(_ newsData: NewsData)
    func loadComment(_ comment: Comment)
    func deleteComment()
}
