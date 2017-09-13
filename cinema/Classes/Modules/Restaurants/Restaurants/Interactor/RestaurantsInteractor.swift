//
// Created by Alexander Maslennikov on 21/07/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Moya
import RxMoya
import CoreLocation
import RxSwift

class RestaurantsInteractor {

    var provider: RxMoyaProvider<FoodleTarget>!
    var locationManager: LocationManagerProtocol!
    weak var output: RestaurantsInteractorOutput!

    fileprivate let disposeBag = DisposeBag()
}

// MARK: - RestaurantsInteractorInput

extension RestaurantsInteractor: RestaurantsInteractorInput {

    var coordinate: CLLocationCoordinate2D? {
        guard let location = locationManager.location else {
            log.warning("User location not found")
            return nil
        }
        return location.coordinate
    }

    func startFetchingUserLocation() {
        locationManager.startMonitoringLocation()
    }

    func fetchRestaurants() {
        provider.requestModel(.restaurants(coordinate: coordinate))
            .subscribe { [unowned self] (response: Event<RestaurantsResponse>) in
                switch response {
                case let .next(model):
                    self.output.successFetch(restaurants: model.restaurants)
                case let .error(error as ProviderError):
                    self.output.finishFetchRestaurants(errorMessage: error.fullMessage)
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }
}

// MARK: - LocationManagerOutput

extension RestaurantsInteractor: LocationManagerOutput {

    func didUpdate(location: CLLocation?) {
        output.needUpdate(coordinate: location?.coordinate)
    }
}
