//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import RxMoya
import RxSwift

class RegistrationInteractor {
    fileprivate let disposeBag = DisposeBag()
    var provider: RxMoyaProvider<FoodleTarget>!
    weak var output: RegistrationInteractorOutput!

}

// MARK: - RegistrationInteractorInput

extension RegistrationInteractor: RegistrationInteractorInput {
    func sendRegInfo(password: String, name: String, phone: String, phoneIn: String) {

        provider.requestModel(.registration(password: password, name: name, phone: phone))
            .subscribe { [unowned self] (response: Event<RegistrationResponse>) in
                switch response {
                case let .next(model):
                    self.output.getUid(uid: model.uid, phone: phoneIn)
                case let .error(error as ProviderError):
                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }
}
