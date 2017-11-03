//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import RxMoya
import RxSwift

class AuthCinemaInteractor {

    weak var output: AuthCinemaInteractorOutput!
    var provider: RxMoyaProvider<FoodleTarget>!
    var authTokenManager: AuthTokenManagerProtocol!

    fileprivate let disposeBag = DisposeBag()
}

// MARK: - AuthCinemaInteractorInput

extension AuthCinemaInteractor: AuthCinemaInteractorInput {
    func sendData(password: String, phone: String) {

        provider.requestModel(.auth(phone: phone, password: password))
            .subscribe { [unowned self] (response: Event<AuthResponse>) in
                switch response {
                case let .next(model):
                    self.authTokenManager.save(apiToken: model.token)
                    self.output.authSeccess()
                case let .error(error as ProviderError):
                    self.output.faulireAuth()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }
}
