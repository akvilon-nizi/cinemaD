//
// Created by Danila Lyahomskiy on 28/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol ReviewsViewInput: class {

    func setupInitialState()

    func openComments(_ comments: [Comment])

    func showNetworkError()

    func addComment(_ comment: Comment)

}

protocol ReviewsViewOutput {

    func viewIsReady()

    func backTap()

    func homeTap()

    func sendReview(name: String, description: String)
}
