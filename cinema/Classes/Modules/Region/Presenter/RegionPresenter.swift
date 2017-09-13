//
// Created by incetro on 24/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class RegionPresenter {

    weak var view: RegionViewInput!
    var interactor: RegionInteractorInput!
    var router: RegionRouterInput!
    weak var output: RegionModuleOutput?

    var needToReturn = false

    let profileRegion: Region?

    init(region: Region?) {

        profileRegion = region
    }
}

// MARK: - RegionViewOutput

extension RegionPresenter: RegionViewOutput {

    func viewIsReady() {
        log.verbose("Region is ready")
        interactor.obtainCities()
    }

    func didSelectRegion(_ region: Region) {

        interactor.save(region: region)
    }

    func backButtonTapped() {

        router.close()
    }
}

// MARK: - RegionInteractorOutput

extension RegionPresenter: RegionInteractorOutput {

    func saveCitySuccess(city: Region) {

        if profileRegion == nil {

            if needToReturn {

                router.close()

            } else {

                router.openTerms()
            }

        } else {

            router.close()
        }
    }

    func saveCityFailure(errorMessage: String) {

        log.error("Finish save city with error: \(errorMessage)")
        router.performTransitionToNetworkAlert(message: errorMessage)
    }

    func obtainCitiesSuccess(cities: [Region]) {

        view.setupInitialState(withRegions: cities, selected: profileRegion, isSelect: needToReturn)
    }

    func obtainCitiesFailure(errorMessage: String) {

        log.error("Finish fetch cities with error: \(errorMessage)")
        router.performTransitionToNetworkAlert(message: errorMessage)
    }
}
