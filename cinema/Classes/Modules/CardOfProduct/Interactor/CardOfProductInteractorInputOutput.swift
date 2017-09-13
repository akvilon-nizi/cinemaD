//
// Created by DanilaLyahomskiy on 01/09/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol CardOfProductInteractorInput {
    func obtainProduct(byProductID productID: Int)
}

protocol CardOfProductInteractorOutput: class {
    func obtainProductSuccess(product: Product)
    func obtainProductFailure(errorMessage: String)
}
