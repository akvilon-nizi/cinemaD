//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol MainInteractorInput {
    func getData()
    func getNewsWithFilters(filters: [String])
    func postLocation(lat: Double, log: Double)
}

protocol MainInteractorOutput: class {
    func getError()
    func tokenError()
    func getData(mainData: MainData)
    func getNews(mainData: MainData)
}
