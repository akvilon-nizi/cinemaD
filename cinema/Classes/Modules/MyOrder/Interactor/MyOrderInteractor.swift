//
// Created by DanilaLyahomskiy on 05/09/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import RxMoya
import RxSwift

class MyOrderInteractor {

    weak var output: MyOrderInteractorOutput!

    var provider: RxMoyaProvider<FoodleTarget>!
    fileprivate let disposeBag = DisposeBag()
}

// MARK: - MyOrderInteractorInput

extension MyOrderInteractor: MyOrderInteractorInput {
    func obtainOrders(count: Int, page: Int) {
        provider.requestModel(.orders(count: count, page: 1))
            .subscribe { [unowned self] (response: Event<OrdersResponse>) in
                switch response {
                case let .next(model):
                    self.output.obtainOrdersSuccess(orders: model.orders)
                case let .error(error as ProviderError):
                    self.output.obtainOrdersFailure(errorMessage: error.message)
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }
}
