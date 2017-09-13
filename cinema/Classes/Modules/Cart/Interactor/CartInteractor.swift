//
// Created by incetro on 17/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Moya
import RxMoya
import RxSwift

class CartInteractor {

    var provider: RxMoyaProvider<FoodleTarget>!
    weak var output: CartInteractorOutput!

    fileprivate let disposeBag = DisposeBag()
}

// MARK: - CartInteractorInput

extension CartInteractor: CartInteractorInput {

    func incrementProductInCart(productID: Int) {

        provider.requestModel(.incrementProductCount(productID: productID))
            .subscribe { [unowned self] (response: Event<CartResponse>) in
                switch response {
                case let .next(model):
                    self.output.incrementProductInCartSuccess(cart: model.cart)
                case let .error(error as ProviderError):
                    self.output.incrementProductInCartFailure(errorMessage: error.message)
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    func decrementProductInCart(productID: Int) {

        provider.requestModel(.decrementProductCount(productID: productID))
            .subscribe { [unowned self] (response: Event<CartResponse>) in
                switch response {
                case let .next(model):
                    self.output.decrementProductInCartSuccess(cart: model.cart)
                case let .error(error as ProviderError):
                    self.output.decrementProductInCartFailure(errorMessage: error.message)
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    func clearCart() {

        provider.requestModel(.clearCart)
            .subscribe { [unowned self] (response: Event<CartResponse>) in
                switch response {
                case let .next(model):
                    self.output.obtainCartSucces(cart: model.cart)
                case let .error(error as ProviderError):
                    self.output.obtainCartFailure(errorMessage: error.message)
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    func obtainCart() {

        provider.requestModel(.cart)
            .subscribe { [unowned self] (response: Event<CartResponse>) in
                switch response {
                case let .next(model):
                    self.output.obtainCartSucces(cart: model.cart)
                case let .error(error as ProviderError):
                    self.output.obtainCartFailure(errorMessage: error.message)
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }
}
