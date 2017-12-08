//
// Created by akvilon-nizi on 16/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol NewsViewInput: class {

    func setupInitialState()

    func openNews(_ newsData: NewsData)

    func showNetworkError()

    func addComment(_ comment: Comment)

    func deleteComment()
}

protocol NewsViewOutput {

    func viewIsReady()

    func backButtonTap()

    func homeButtonTap()

    func sendMessage(message: String)

    func deleteComment(id: String)
}
