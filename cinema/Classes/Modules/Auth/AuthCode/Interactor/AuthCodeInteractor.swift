//
// Created by incetro on 21/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Moya
import RxMoya
import RxSwift

class AuthCodeInteractor {

    var regionManager: RegionManager!
    weak var output: AuthCodeInteractorOutput!
    var provider: RxMoyaProvider<FoodleTarget>!
    var authTokenManager: AuthTokenManagerProtocol!

    fileprivate let disposeBag = DisposeBag()
}

// MARK: - AuthCodeInteractorInput

extension AuthCodeInteractor: AuthCodeInteractorInput {

    var regionWasChosen: Bool {

        return regionManager.region != nil
    }

    func sendSMSCode(phone: String) {

        provider.requestModel(.sendCode(phone: phone))
            .subscribe { [unowned self] (response: Event<ServerResponse>) in
                switch response {
                case .next:
                    self.output.sendSMSCodeSuccess(phone: phone)
                case let .error(error as ProviderError):
                    self.output.sendSMSCodeFailure(errorMessage: error.message)
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    private func checkCode(phone: String, code: String) {

        provider.requestModel(.checkCode(phone: phone, code: code))
            .subscribe { [unowned self] (response: Event<AuthCheckCodeResponse>) in
                switch response {
                case let .next(model):
                    self.authTokenManager.save(apiToken: model.token)
                    self.output.checkSMSCodeSuccess(phone: phone)
                case let .error(error as ProviderError):
                    self.output.checkSMSCodeFailure(errorMessage: error.message)
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    private func confirmCode(phone: String, code: String) {

        provider.requestModel(.confirm(code: code))
            .subscribe { [unowned self] (response: Event<ServerResponse>) in
                switch response {
                case .next:
                    self.output.checkSMSCodeSuccess(phone: phone)
                case let .error(error as ProviderError):
                    self.output.checkSMSCodeFailure(errorMessage: error.message)
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    func checkSMSCode(phone: String, code: String, isAuth: Bool) {

        if isAuth {

            checkCode(phone: phone, code: code)

        } else {

            confirmCode(phone: phone, code: code)
        }
    }
}
