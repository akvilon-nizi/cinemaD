//
// Created by incetro on 22/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol CategoryMenuModuleInput: class {

    func setActualData(_ products: [Product])

    func setModuleOutput(_ output: CategoryMenuModuleOutput)

    func updateProducts(_ products: [Product])
}

protocol CategoryMenuModuleOutput: class {

    func updateCart(_ cart: Cart)
}
