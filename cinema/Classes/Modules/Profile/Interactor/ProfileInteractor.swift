//
// Created by incetro on 25/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import RxMoya
import RxSwift

class ProfileInteractor {

    weak var output: ProfileInteractorOutput!
    var provider: RxMoyaProvider<FoodleTarget>!
    var logoutManager: LogoutManager!

    fileprivate let disposeBag = DisposeBag()
}

// MARK: - ProfileInteractorInput

extension ProfileInteractor: ProfileInteractorInput {

    private func turnOffNotifications(_ completion: @escaping () -> Void) {

        provider.requestModel(.turnNotifications(enabled: false))

            .subscribe { [unowned self] (response: Event<ProfileResponse>) in
                switch response {
                case .next:

                    completion()

                case let .error(error as ProviderError):
                    self.output.logoutFailure(errorMessage: error.message)
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    func logout() {

        turnOffNotifications {

            self.provider.requestModel(.logout)

                .subscribe { [unowned self] (response: Event<ServerResponse>) in
                    switch response {
                    case .next:
                        self.logoutManager.clearData()
                        self.output.logoutSuccess()
                    case let .error(error as ProviderError):
                        self.output.logoutFailure(errorMessage: error.message)
                    default:
                        break
                    }
                }
                .addDisposableTo(self.disposeBag)
        }
    }

    func turnNotifications(enabled: Bool) {

        provider.requestModel(.turnNotifications(enabled: enabled))
            .subscribe { [unowned self] (response: Event<ProfileResponse>) in
                switch response {
                case let .next(model):
                    self.output.turnNotificationsSuccess(profile: model.profile)
                case let .error(error as ProviderError):
                    self.output.turnNotificationsFailure(errorMessage: error.message)
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    func obtainProfile() {

        provider.requestModel(.users(id: 0))
            .subscribe { [unowned self] (response: Event<ProfileResponse>) in
                switch response {
                case let .next(model):
                    self.output.obtainProfileSuccess(profile: model.profile)
                case let .error(error as ProviderError):
                    self.output.obtainProfileFailure(errorMessage: error.message)
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }
}
