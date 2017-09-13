//
// Created by DanilaLyahomskiy on 01/09/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Moya
import RxMoya
import RxSwift

class CardOfProductInteractor {

    weak var output: CardOfProductInteractorOutput!

    var provider: RxMoyaProvider<FoodleTarget>!
    fileprivate let disposeBag = DisposeBag()
}

// MARK: - CardOfProductInteractorInput

extension CardOfProductInteractor: CardOfProductInteractorInput {
    func obtainProduct(byProductID productID: Int) {

        provider.requestModel(.product(productID: productID))
            .subscribe { [unowned self] (response: Event<ProductResponse>) in
                switch response {
                case let .next(model):
                    self.output.obtainProductSuccess(product: model.product)
                case let .error(error as ProviderError):
                    self.output.obtainProductFailure(errorMessage: error.message)
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }
}
