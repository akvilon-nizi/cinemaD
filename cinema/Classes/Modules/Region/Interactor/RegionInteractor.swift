//
// Created by incetro on 24/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import RxMoya
import RxSwift

class RegionInteractor {

    weak var output: RegionInteractorOutput!
    var regionManager: RegionManager!
    var provider: RxMoyaProvider<FoodleTarget>!

    fileprivate let disposeBag = DisposeBag()
}

// MARK: - RegionInteractorInput

extension RegionInteractor: RegionInteractorInput {

    func save(region: Region) {

        provider.requestModel(.updateRegion(cityID: region.id))
            .subscribe { [unowned self] (response: Event<ProfileResponse>) in
                switch response {
                case .next:
                    self.regionManager.save(region: region)
                    self.output.saveCitySuccess(city: region)
                case let .error(error as ProviderError):
                    self.output.saveCityFailure(errorMessage: error.message)
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    func obtainCities() {

        provider.requestModel(.cities)
            .subscribe { [unowned self] (response: Event<RegionResponse>) in
                switch response {
                case let .next(model):
                    self.output.obtainCitiesSuccess(cities: model.regions)
                case let .error(error as ProviderError):
                    self.output.obtainCitiesFailure(errorMessage: error.message)
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }
}
