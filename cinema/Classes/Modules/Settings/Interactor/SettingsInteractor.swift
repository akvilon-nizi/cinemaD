//
// Created by akvilon-nizi on 23/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import RxSwift
import RxMoya

class SettingsInteractor {

    weak var output: SettingsInteractorOutput!

    fileprivate var disposeBag = DisposeBag()

    var provider: RxMoyaProvider<FoodleTarget>!
}

// MARK: - SettingsInteractorInput

extension SettingsInteractor: SettingsInteractorInput {
    func logout() {
        provider.requestModel(.logout)
            .subscribe { [unowned self] (response: Event<FilmResponse>) in
                switch response {
                case let .next(model):
                    if model.code == 200 {
                        self.output.successLogout()
                    } else {
                        self.output.getError()
                    }
                case let .error(error as ProviderError):
                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }
}
