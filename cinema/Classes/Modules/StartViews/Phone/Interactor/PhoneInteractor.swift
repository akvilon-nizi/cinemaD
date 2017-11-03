//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import RxMoya
import RxSwift

class PhoneInteractor {
    fileprivate let disposeBag = DisposeBag()
    var provider: RxMoyaProvider<FoodleTarget>!
    weak var output: PhoneInteractorOutput!
}

// MARK: - PhoneInteractorInput

extension PhoneInteractor: PhoneInteractorInput {
    func sendSms(phone: String, phoneCorrect: String) {
        provider.requestModel(.restore(phone: phoneCorrect))
            .subscribe { [unowned self] (response: Event<RegistrationResponse>) in
                switch response {
                case let .next(model):
                    self.output.getUid(phone: phone, uid: model.uid)
                case let .error(error as ProviderError):
                    self.output.showError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }
    func sendUid(uid: String) {
    }
}
