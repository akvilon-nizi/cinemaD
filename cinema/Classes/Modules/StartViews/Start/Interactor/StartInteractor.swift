//
// Created by akvilon-nizi on 04/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import RxMoya
import RxSwift

class StartInteractor {

    weak var output: StartInteractorOutput!

    var provider: RxMoyaProvider<FoodleTarget>!

    fileprivate let disposeBag = DisposeBag()

    var authTokenManager: AuthTokenManagerProtocol!
}

// MARK: - StartInteractorInput

extension StartInteractor: StartInteractorInput {
    func sendData(authCode: String) {
        provider.requestModel(.auth2(authCode: authCode))
            .subscribe { [unowned self] (response: Event<AuthResponse>) in
                switch response {
                case let .next(model):
                    self.authTokenManager.save(apiToken: model.token)
                    self.output.authSuccess()
                case let .error(error as ProviderError):
                    print(error)
                    self.output.faulireAuth()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }
}
