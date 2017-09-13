//
// Created by incetro on 22/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class CategoryMenuViewController: ParentViewController {

    let builder = RestaurantViewDataBuilder()
    let favoriteView = ProductsView(contentManager: ProductsViewContentManager(), scrollDirection: .vertical)

    var output: CategoryMenuViewOutput!

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()

        favoriteView.delegate = self

        favoriteView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(favoriteView)
        favoriteView.pinToSuperview([.left, .right])
        favoriteView.heightAnchor ~= UIScreen.main.bounds.height - 106
        favoriteView.bottomAnchor ~= view.bottomAnchor
    }
}

// MARK: - CategoryMenuViewInput

extension CategoryMenuViewController: CategoryMenuViewInput {

    func setupInitialState(withProducts products: [Product]) {

        favoriteView.setup(withItems: builder.favorireMealObjects(fromProducts: products))
    }

    func updateContent(withProducts products: [Product]) {

        favoriteView.contentManager.products = builder.favorireMealObjects(fromProducts: products)
        favoriteView.stopRefreshing()
    }

    func appendProducts(_ products: [Product]) {

    }

    func updateProduct(_ product: Product) {

        favoriteView.updateProduct(builder.favorireMealObject(fromProduct: product))
    }

    func updateProducts(_ products: [Product]) {

        let current = favoriteView.contentManager.products

        for product in current {

            if let index = products.index(where: { $0.id == product.id }) {

                favoriteView.updateProduct(builder.favorireMealObject(fromProduct: products[index]))

            } else {

                favoriteView.clearProductCount(byProductID: product.id)
            }
        }
    }

    func clearProductCount(_ productID: Int) {

        favoriteView.clearProductCount(byProductID: productID)
    }
}

// MARK: - ProductsViewDelegate

extension CategoryMenuViewController: ProductsViewDelegate {

    func incrementButtonTapped(product: ProductCellObject) {

        output.incrementProductCount(productID: product.id)
    }

    func decrementButtonTapped(product: ProductCellObject) {

        output.decrementProductCount(productID: product.id)
    }

    func addButtonTapped(product: ProductCellObject) {

        output.didTapAddProduct(withProductID: product.id)
    }

    func needToRefresh() {

        output.neddToRefresh()
    }

    func openProductInfo(product: ProductCellObject) {
        output.showProductInfo(productID: product.id)
    }
}
