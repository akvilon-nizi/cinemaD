//
// Created by Danila Lyahomskiy on 11/12/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import RxMoya
import RxSwift

class AdminCollectionInteractor {

    weak var output: AdminCollectionInteractorOutput!

    var provider: RxMoyaProvider<FoodleTarget>!

    let disposeBag = DisposeBag()
}

// MARK: - AdminCollectionInteractorInput

extension AdminCollectionInteractor: AdminCollectionInteractorInput {

    func getAdminCollections(id: String) {
        provider.requestModel(.getAdminCollection(id: id))
            .subscribe { [unowned self] (response: Event<Collection>) in
                switch response {
                case let .next(model):
                    self.output.getCollection(model)
                case let .error(error as ProviderError):
                    if error.status == 403 {
                        self.output.tokenError()
                    } else {
                        self.output.getError()
                    }
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

}
