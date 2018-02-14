//
// Created by akvilon-nizi on 16/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import RxMoya
import RxSwift

class RewardsInteractor {

    weak var output: RewardsInteractorOutput!
    var provider: RxMoyaProvider<FoodleTarget>!
    fileprivate var disposeBag = DisposeBag()
}

// MARK: - RewardsInteractorInput

extension RewardsInteractor: RewardsInteractorInput {
    func getAdwards() {
        provider.requestModel(.adwards)
            .subscribe { [unowned self] (response: Event<AdwardsResponse>) in
                switch response {
                case let .next(model):
                     self.output.getAwards(awards: model.adwards)
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
