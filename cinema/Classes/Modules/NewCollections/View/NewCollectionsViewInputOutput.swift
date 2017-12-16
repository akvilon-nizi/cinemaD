//
// Created by akvilon-nizi on 31/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol NewCollectionsViewInput: class {

    func setupInitialState()

    func setCollections(collections: [Film])

    func getError()

    func getSeccess(message: String)

    func getSearch(_ films: [Film])
}

protocol NewCollectionsViewOutput {

    func viewIsReady()

    func backButtonTap()

    func addNewFilm(name: String, films: [Film])

    func patchCollections(name: String, films: [Film])

    func deleteCollections()

    func getQuery(_ text: String)
}
