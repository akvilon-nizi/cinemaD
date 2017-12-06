//
// Created by akvilon-nizi on 24/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import RxMoya
import RxSwift
import UIKit

class EditingProfileInteractor {

    weak var output: EditingProfileInteractorOutput!
    var provider: RxMoyaProvider<FoodleTarget>!
    fileprivate var disposeBag = DisposeBag()
}

// MARK: - EditingProfileInteractorInput

extension EditingProfileInteractor: EditingProfileInteractorInput {
    func editeProfile(image: UIImage?, name: String, oldPassword: String, password: String) {
        provider.requestModel(.editeProfile(image: image, name: name, oldPassword: oldPassword, newPassword: oldPassword))
            .subscribe { [unowned self] (response: Event<ProfileModel>) in
                switch response {
                case let .next(model):
                    self.output.successEditing(model)
                case let .error(error as ProviderError):
                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }
}
