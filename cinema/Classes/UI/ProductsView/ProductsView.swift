//
//  ProductsView.swift
//  foodle
//
//  Created by incetro on 09/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

protocol ProductsViewDelegate: class {

    func incrementButtonTapped(product: ProductCellObject)

    func decrementButtonTapped(product: ProductCellObject)

    func addButtonTapped(product: ProductCellObject)

    func openProductInfo(product: ProductCellObject)

    func needToRefresh()
}

// MARK: - ProductsView

class ProductsView: UIView {

    static let heightConstant: CGFloat = 240

    var delegate: ProductsViewDelegate? {

        didSet {

            contentManager.delegate = self
        }
    }

    private let refreshControl = UIRefreshControl()

    private var collectionview: UICollectionView = {

        let layout = UICollectionViewFlowLayout()

        let inset: CGFloat = 12
        layout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - inset * 4) / 2, height: 206)
        layout.scrollDirection = .horizontal

        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionview.clipsToBounds = true
        collectionview.showsHorizontalScrollIndicator = false
        collectionview.backgroundColor = .clear
        collectionview.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseIdentifier)

        return collectionview
    }()

    let contentManager: ProductsViewContentManager

    private func createLayout(scrollDirection: UICollectionViewScrollDirection) -> UICollectionViewFlowLayout {

        let height: CGFloat
        let width: CGFloat

        let ratio: CGFloat = 1.44

        if scrollDirection == .horizontal {

            height = ProductsView.heightConstant - 8 * 2
            width = height / ratio

        } else {

            width = (UIScreen.main.bounds.width - 35) / 2
            height = width * ratio
        }

        let layout = UICollectionViewFlowLayout()
        let inset: CGFloat = 4

        layout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        layout.itemSize = CGSize(width: width, height: height)
        layout.scrollDirection = scrollDirection

        return layout
    }

    init(contentManager: ProductsViewContentManager, scrollDirection: UICollectionViewScrollDirection = .horizontal) {

        self.contentManager = contentManager

        super.init(frame: .zero)

        collectionview.setCollectionViewLayout(createLayout(scrollDirection: scrollDirection), animated: false)

        self.contentManager.collectionView = collectionview

        backgroundColor = .clear
    }

    func setup(withItems items: [ProductCellObject]) {

        contentManager.products = items

        setupCollectionView()
    }

    func updateProduct(_ product: ProductCellObject) {

        contentManager.updateProduct(product)
    }

    func clearProductCount(byProductID productID: Int) {

        contentManager.clearProductCount(byProductID: productID)
    }

    func refreshing() {

        delegate?.needToRefresh()
    }

    func stopRefreshing() {

        refreshControl.endRefreshing()
    }

    private func setupCollectionView() {

        addSubview(collectionview)

        collectionview.translatesAutoresizingMaskIntoConstraints = false
        collectionview.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7).isActive = true
        collectionview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7).isActive = true

        collectionview.showsVerticalScrollIndicator = false
        collectionview.backgroundColor = UIColor.clear
        collectionview.refreshControl = refreshControl

        refreshControl.addTarget(self, action: #selector(refreshing), for: .valueChanged)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ProductsViewContentManagerDelegate

extension ProductsView: ProductsViewContentManagerDelegate {

    func decrementButtonTapped(product: ProductCellObject) {

        delegate?.decrementButtonTapped(product: product)
    }

    func incrementButtonTapped(product: ProductCellObject) {

        delegate?.incrementButtonTapped(product: product)
    }

    func addButtonTapped(product: ProductCellObject) {

        delegate?.addButtonTapped(product: product)
    }

    func productTapped(product: ProductCellObject) {
        delegate?.openProductInfo(product: product)
    }
}
