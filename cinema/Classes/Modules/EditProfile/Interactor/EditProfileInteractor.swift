//
// Created by incetro on 26/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Alamofire
import RxMoya
import RxSwift
import UIKit

class EditProfileInteractor {

    weak var output: EditProfileInteractorOutput!
    var provider: RxMoyaProvider<FoodleTarget>!

    fileprivate let disposeBag = DisposeBag()
}

// MARK: - EditProfileInteractorInput

extension EditProfileInteractor: EditProfileInteractorInput {

    func removeAvatar() {

        provider.requestModel(.removeAvatar)
            .subscribe { [unowned self] (response: Event<ProfileResponse>) in
                switch response {
                case let .next(model):
                    self.output.removeAvatarSuccess(profile: model.profile)
                case let .error(error as ProviderError):
                    self.output.removeAvatarFailure(errorMessage: error.message)
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    private func uploadAvatar(upload: Upload) {

        provider.requestModel(.updateAvatar(id: upload.id))
            .subscribe { [unowned self] (response: Event<ProfileResponse>) in
                switch response {
                case let .next(model):
                    self.output.uploadAvatarSuccess(profile: model.profile)
                case let .error(error as ProviderError):
                    self.output.uploadAvatarFailure(errorMessage: error.message)
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    func uploadAvatar(image: UIImage) {

        guard let data = UIImageJPEGRepresentation(image, 0.5) else {

            return
        }

        provider.requestModel(.uploadData(data: data))
            .subscribe { [unowned self] (response: Event<UploadResponse>) in
                switch response {
                case let .next(model):
                    self.uploadAvatar(upload: model.upload)
                case let .error(error as ProviderError):
                    self.output.uploadAvatarFailure(errorMessage: error.message)
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

    func updateProfile(_ profile: Profile) {

        provider.requestModel(.updateProfile(profile: profile))
            .subscribe { [unowned self] (response: Event<ProfileResponse>) in
                switch response {
                case let .next(model):
                    self.output.updateProfileSuccess(profile: model.profile)
                case let .error(error as ProviderError):
                    self.output.updateProfileFailure(errorMessage: error.message)
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }
}
