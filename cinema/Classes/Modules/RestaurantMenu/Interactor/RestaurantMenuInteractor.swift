//
// Created by incetro on 12/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Moya
import RxMoya
import RxSwift

class RestaurantMenuInteractor {

    var provider: RxMoyaProvider<FoodleTarget>!
    weak var output: RestaurantMenuInteractorOutput!

    fileprivate let disposeBag = DisposeBag()
}

// MARK: - RestaurantMenuInteractorInput

extension RestaurantMenuInteractor: RestaurantMenuInteractorInput {

    func obtainCart() {

        provider.requestModel(.cart)
            .subscribe { [unowned self] (response: Event<CartResponse>) in
                switch response {
                case let .next(model):
                    self.output.obtainCartSuccess(cart: model.cart)
                case let .error(error as ProviderError):
                    self.output.obtainCartFailure(errorMessage: error.message)
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    func obtainProducts(restaurant: FullRestaurant) {

        let queue = DispatchQueue(label: "RestaurantMenuInteractor.categories", attributes: .concurrent, target: .main)
        let group = DispatchGroup()
        var errorMessage: String? = nil
        var products: [Int: [Product]] = [:]

        for category in restaurant.categories {

            group.enter()
            queue.async {

            self.provider.requestModel(.products(restaurantID: restaurant.id, categoryID: category.id, count: 30, page: 1))
                .subscribe { (response: Event<ProductsResponse>) in
                    switch response {

                    case let .next(model):
                        products[category.id] = model.products
                        group.leave()

                    case let .error(error as ProviderError):
                        errorMessage = error.message
                        group.leave()

                    default:
                        break
                    }
                }
                .addDisposableTo(self.disposeBag)
            }
        }

        group.notify(queue: .main) {

            if let errorMessage = errorMessage {

                self.output.obtainProductsFailure(errorMessage: errorMessage)

            } else {

                self.output.obtainProductsSuccess(products: products)
            }
        }
    }
}
