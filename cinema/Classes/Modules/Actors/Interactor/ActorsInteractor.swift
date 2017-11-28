//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import RxMoya
import RxSwift

class ActorsInteractor {

    weak var output: ActorsInteractorOutput!

    var provider: RxMoyaProvider<FoodleTarget>!

    let disposeBag = DisposeBag()
}

// MARK: - ActorsInteractorInput

extension ActorsInteractor: ActorsInteractorInput {
    func getPersonInfo(id: String) {
        provider.requestModel(.person(personID: id))
            .subscribe { [unowned self] (response: Event<FullPerson>) in
                switch response {
                case let .next(model):
                    self.output.getPersonInfo(person: model)
                case let .error(error as ProviderError):
                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }
}
