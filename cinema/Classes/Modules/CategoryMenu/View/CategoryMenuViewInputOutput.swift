//
// Created by incetro on 22/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol CategoryMenuViewInput: class {

    func updateContent(withProducts products: [Product])
    func setupInitialState(withProducts products: [Product])
    func appendProducts(_ products: [Product])
    func updateProduct(_ product: Product)
    func updateProducts(_ products: [Product])
    func clearProductCount(_ productID: Int)
}

protocol CategoryMenuViewOutput {

    func viewIsReady()

    func didTapAddProduct(withProductID productID: Int)

    func incrementProductCount(productID: Int)

    func decrementProductCount(productID: Int)

    func neddToRefresh()

    func showProductInfo(productID: Int)
}
