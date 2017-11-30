//
// Created by Danila Lyahomskiy on 28/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol ReviewsInteractorInput {
    func getComment(filmID: String)

    func putComment(filmID: String, message: String)
}

protocol ReviewsInteractorOutput: class {

    func getComments(_ comments: [Comment])

    func loadComment(_ comment: Comment)

    func getError()
}
