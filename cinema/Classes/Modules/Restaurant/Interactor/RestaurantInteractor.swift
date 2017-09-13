//
// Created by Alexander Maslennikov on 24/07/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Moya
import RxMoya
import RxSwift

class RestaurantInteractor {

    var provider: RxMoyaProvider<FoodleTarget>!
    weak var output: RestaurantInteractorOutput!

    fileprivate let disposeBag = DisposeBag()
}

// MARK: - RestaurantInteractorInput

extension RestaurantInteractor: RestaurantInteractorInput {

    func obtainRestaurant(byRestaurantID restaurantID: Int) {

        provider.requestModel(.restaurant(restaurantID: restaurantID))
            .subscribe { [unowned self] (response: Event<FullRestaurantResponse>) in
                switch response {
                case let .next(model):
                    self.output.obtainRestaurantSuccess(restaurant: model.restaurant)
                case let .error(error as ProviderError):
                    self.output.obtainRestaurantFailure(errorMessage: error.message)
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }
}
