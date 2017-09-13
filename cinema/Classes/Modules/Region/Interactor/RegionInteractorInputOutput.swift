//
// Created by incetro on 24/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol RegionInteractorInput {

    func obtainCities()

    func save(region: Region)
}

protocol RegionInteractorOutput: class {

    func obtainCitiesSuccess(cities: [Region])
    func obtainCitiesFailure(errorMessage: String)

    func saveCitySuccess(city: Region)
    func saveCityFailure(errorMessage: String)
}
