//
// Created by DanilaLyahomskiy on 01/09/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol CardOfProductViewInput: class {

    func setupInitialState(withProduct product: Product)

    func showEmptyLoading()

    func show(error: String)
}

protocol CardOfProductViewOutput {

    func viewIsReady()

    func close()

    func reloadData()
}
