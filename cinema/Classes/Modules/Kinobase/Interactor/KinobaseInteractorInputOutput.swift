//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol KinobaseInteractorInput {
    func getWatched()
    func getFilmsIntoCol(idCol: String)
    func searchFilms(query: String, genres: [String], years: [String], isWatched: Bool)
}

protocol KinobaseInteractorOutput: class {
    func getError()
    func getData(_ kbData: KinobaseData)
    func getCollection(_ collection: Collection)
    func getSearch(_ kbData: KinobaseData, isWatched: Bool)
}
