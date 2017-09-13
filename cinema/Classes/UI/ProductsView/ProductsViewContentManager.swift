//
//  ProductsViewContentManagerDelegate.swift
//  foodle
//
//  Created by incetro on 10/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - ProductsViewContentManagerDelegate

protocol ProductsViewContentManagerDelegate: class {

    func incrementButtonTapped(product: ProductCellObject)

    func decrementButtonTapped(product: ProductCellObject)

    func addButtonTapped(product: ProductCellObject)

    func productTapped(product: ProductCellObject)
}

// MARK: - ProductsViewContentManager

class ProductsViewContentManager: NSObject {

    weak var delegate: ProductsViewContentManagerDelegate?

    var products: [ProductCellObject] = [] {

        didSet {

            collectionView?.reloadData()
        }
    }

    var collectionView: UICollectionView? {

        didSet {

            collectionView?.dataSource = self
            collectionView?.delegate = self
            collectionView?.reloadData()
        }
    }

    func updateProduct(_ product: ProductCellObject) {

        guard let index = products.index(where: { $0.id == product.id }) else {

            return
        }

        products[index] = product
    }

    func clearProductCount(byProductID productID: Int) {

        guard let index = products.index(where: { $0.id == productID }) else {

            return
        }

        products[index].quantityInCart = 0
    }
}

// MARK: - UICollectionViewDataSource

extension ProductsViewContentManager: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let identifier = ProductCell.reuseIdentifier

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? ProductCell else {

            fatalError("Cannot dequeue cell with identifier '\(ProductCell.reuseIdentifier)'")
        }

        cell.setData(products[indexPath.row])
        cell.delegate = self

        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension ProductsViewContentManager: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.productTapped(product: products[indexPath.row])
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProductsViewContentManager: UICollectionViewDelegateFlowLayout {

}

// MARK: - ProductCellDelegate

extension ProductsViewContentManager: ProductCellDelegate {

    func incrementButtonTapped(product: ProductCellObject) {

        delegate?.incrementButtonTapped(product: product)
    }

    func decrementButtonTapped(product: ProductCellObject) {

        delegate?.decrementButtonTapped(product: product)
    }

    func addButtonTapped(product: ProductCellObject) {

        delegate?.addButtonTapped(product: product)
    }
}
