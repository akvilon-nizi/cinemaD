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
}

// MARK: - StartInteractorInput

extension StartInteractor: StartInteractorInput {
    
}
