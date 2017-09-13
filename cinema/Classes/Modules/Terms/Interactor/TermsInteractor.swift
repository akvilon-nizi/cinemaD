//
// Created by incetro on 25/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import RxMoya
import RxSwift

class TermsInteractor {

    weak var output: TermsInteractorOutput!
    var termsManager: TermsManager!
    var provider: RxMoyaProvider<FoodleTarget>!

    fileprivate let disposeBag = DisposeBag()
}

// MARK: - TermsInteractorInput

extension TermsInteractor: TermsInteractorInput {

    func setConfirmed() {

        termsManager.setConfirmed()
    }

    func obtainTerms() {

        provider.requestModel(.terms)
            .subscribe { [unowned self] (response: Event<TermsResponse>) in
                switch response {
                case let .next(model):
                    self.output.obtainTermsSuccess(terms: model.terms)
                case let .error(error as ProviderError):
                    self.output.obtainTermsFailure(errorMessage: error.message)
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }
}
