//
// Created by DanilaLyahomskiy on 01/09/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

class CardOfProductPresenter {

    weak var view: CardOfProductViewInput!
    var interactor: CardOfProductInteractorInput!
    var router: CardOfProductRouterInput!
    weak var output: CardOfProductModuleOutput?

    let productId: Int

    var product: Product?

    init(id: Int) {
        productId = id
    }
}

// MARK: - CardOfProductViewOutput

extension CardOfProductPresenter: CardOfProductViewOutput {

    func viewIsReady() {
        log.verbose("CardOfProduct is ready")
        interactor.obtainProduct(byProductID: productId)
        view.showEmptyLoading()
    }

    func reloadData() {
        interactor.obtainProduct(byProductID: productId)
        view.showEmptyLoading()
    }

    func close() {
        router.close()
    }
}

// MARK: - CardOfProductInteractorOutput

extension CardOfProductPresenter: CardOfProductInteractorOutput {
    func obtainProductSuccess(product: Product) {
        view.setupInitialState(withProduct: product)
    }
    func obtainProductFailure(errorMessage: String) {
        log.error("Finish fetch restaurant with error: \(errorMessage)")
        view.show(error: errorMessage)
    }
}
