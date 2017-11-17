//
// Created by akvilon-nizi on 16/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol NewsViewInput: class {

    func setupInitialState()

    func openNews(_ news: News)

    func showNetworkError()
}

protocol NewsViewOutput {

    func viewIsReady()

    func backButtonTap()
}
