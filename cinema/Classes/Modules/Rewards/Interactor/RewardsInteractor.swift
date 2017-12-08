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
    var rewardsData = RewardsData()
}

// MARK: - RewardsInteractorInput

extension RewardsInteractor: RewardsInteractorInput {
    func getAdwardsView() {
        provider.requestModel(.adwardsView)
            .subscribe { [unowned self] (response: Event<AdwardsResponse>) in
                switch response {
                case let .next(model):
                    self.rewardsData.awardsView = model.adwards
                    self.getAdwardsGeo()
                case let .error(error as ProviderError):
                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    func getAdwardsGeo() {
        provider.requestModel(.adwardsGeo)
            .subscribe { [unowned self] (response: Event<AdwardsResponse>) in
                switch response {
                case let .next(model):
                    self.rewardsData.awardsGeo = model.adwards
                    self.output.getAwards(awards: self.rewardsData)
                case let .error(error as ProviderError):
                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }
}
