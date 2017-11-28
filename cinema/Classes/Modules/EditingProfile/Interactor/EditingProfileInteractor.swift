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
    func loadAvatar(image: UIImage) {
        provider.requestModel(.loadAvatar(image: image))
            .subscribe { [unowned self] (response: Event<LoadImageResponse>) in
                switch response {
                case let .next(model):
                    self.output.successEditing()
                case let .error(error as ProviderError):
                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }
}
