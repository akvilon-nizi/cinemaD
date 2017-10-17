//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import RxMoya
import RxSwift

class MainInteractor {

    weak var output: MainInteractorOutput!
    var provider: RxMoyaProvider<FoodleTarget>!
    fileprivate let disposeBag = DisposeBag()

}

// MARK: - MainInteractorInput

extension MainInteractor: MainInteractorInput {
    func getTrailers() {
        provider.requestModel(.person(personID:"ce13f2d3-45f9-4478-ac71-514c719e6597"))
            .subscribe { [unowned self] (response: Event<FullPerson>) in
                switch response {
                case let .next(model):
                    print()
                case let .error(error as ProviderError):
                    print()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }
}
