//
// Created by incetro on 22/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Moya
import RxMoya
import RxSwift

class CategoryMenuInteractor {

    var provider: RxMoyaProvider<FoodleTarget>!
    weak var output: CategoryMenuInteractorOutput!

    var productsMapper: ProductsMapper = ProductsMapperImplementation()

    fileprivate let disposeBag = DisposeBag()
}

// MARK: - CategoryMenuInteractorInput

extension CategoryMenuInteractor: CategoryMenuInteractorInput {

    func obtainProducts(restaurantID: Int, categoryID: Int) {

        provider.requestModel(.products(restaurantID: restaurantID, categoryID: categoryID, count: 30, page: 1))
            .subscribe { [unowned self] (response: Event<ProductsResponse>) in
                switch response {
                case let .next(model):
                    self.output.obtainProductsSuccess(products: model.products)
                case let .error(error as ProviderError):
                    self.output.obtainProductsFailure(errorMessage: error.message)
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    func incrementProductCountInCart(productID: Int) {

        provider.requestModel(.incrementProductCount(productID: productID))
            .subscribe { [unowned self] (response: Event<CartResponse>) in
                switch response {
                case let .next(model):

                    guard let product = model.cart.products.first(where: { $0.id == productID }) else {

                        return
                    }

                    self.output.incrementProductCountInCartSuccess(product: self.productsMapper.map(product), cart: model.cart)

                case let .error(error as ProviderError):
                    self.output.incrementProductCountInCartFailure(errorMessage: error.message)
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    func decrementProductCountInCart(productID: Int) {

        provider.requestModel(.decrementProductCount(productID: productID))
            .subscribe { [unowned self] (response: Event<CartResponse>) in
                switch response {
                case let .next(model):

                    if let product = model.cart.products.first(where: { $0.id == productID }) {

                        self.output.decrementProductCountInCartSuccess(product: self.productsMapper.map(product), cart: model.cart)

                    } else {

                        self.output.decrementProductCountInCartSuccess(product: nil, cart: model.cart)
                    }

                case let .error(error as ProviderError):
                    self.output.decrementProductCountInCartFailure(errorMessage: error.message)
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }
}
