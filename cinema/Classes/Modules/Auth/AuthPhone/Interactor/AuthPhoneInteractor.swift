//
// Created by Alexander Maslennikov on 04/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import RxMoya
import RxSwift

class AuthPhoneInteractor {

    var provider: RxMoyaProvider<FoodleTarget>!
    weak var output: AuthPhoneInteractorOutput!

    fileprivate let disposeBag = DisposeBag()
}

// MARK: - AuthPhoneInteractorInput

extension AuthPhoneInteractor: AuthPhoneInteractorInput {

    func sendSMSCode(phone: String) {
        provider.requestModel(.sendCode(phone: phone))
            .subscribe { [unowned self] (response: Event<ServerResponse>) in
                switch response {
                case .next:
                    self.output.finishSendSMSCode(phone: phone, errorMessage: nil)
                case let .error(error as ProviderError):
                    self.output.finishSendSMSCode(phone: phone, errorMessage: error.fullMessage)
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }
}
