//
//  RestaurantViewLayouter.swift
//  foodle
//
//  Created by incetro on 11/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

extension UIView {

    func constraint(withIdentifier identifier: String) -> NSLayoutConstraint? {

        return constraints.first { $0.identifier == identifier }
    }
}

// MARK: - RestaurantViewLayouter

class RestaurantViewLayouter {

    private let spacing: CGFloat = 42

    func configureImageView(_ imageView: UIImageView, height: CGFloat, heightConstraintID: String) {

        imageView.pinEdgesToSuperviewEdges(excluding: .bottom)
        let heightConstraint = imageView.heightAnchor ~= height
        heightConstraint.isActive = true
        heightConstraint.identifier = heightConstraintID
    }

    func configureNavigationBarView(_ navigationBarView: RestaurantNavigationBarView, bottomAnchor: NSLayoutYAxisAnchor) {

        navigationBarView.pinEdgesToSuperviewEdges(excluding: .bottom)
        navigationBarView.bottomAnchor ~= bottomAnchor
    }

    func configureScrollView(_ scrollView: UIScrollView, width: CGFloat, top: CGFloat) {

        scrollView.pinEdgesToSuperviewEdges(top: top)
        scrollView.widthAnchor ~= width
    }

    func configureInfoView(_ infoView: RestaurantInfoView, inScrollView view: UIView, width: CGFloat) {

        infoView.topAnchor ~= view.topAnchor + spacing
        infoView.leadingAnchor ~= view.leadingAnchor
        infoView.widthAnchor ~= width
        infoView.heightAnchor ~= Indents.infoViewHeight
    }

    func configureProductsViewLabel(_ productsViewLabel: UILabel, in scrollView: UIScrollView, topAnchor: NSLayoutYAxisAnchor) {

        productsViewLabel.leadingAnchor ~= scrollView.leadingAnchor + 20
        productsViewLabel.topAnchor ~= topAnchor + spacing
    }

    func configureProductsView(_ view: ProductsView,
                               in scrollView: UIScrollView,
                               width: CGFloat,
                               height: CGFloat,
                               bottomAnchor: NSLayoutYAxisAnchor) {

        view.widthAnchor ~= width
        view.heightAnchor ~= height
        view.topAnchor ~= bottomAnchor
        view.leadingAnchor ~= scrollView.leadingAnchor
    }

    func configureMenuView(_ menuView: RestaurantMenuView, inScrollView scrollView: UIScrollView, width: CGFloat, bottomAnchor: NSLayoutYAxisAnchor) {

        menuView.topAnchor ~= bottomAnchor + spacing
        menuView.leadingAnchor ~= scrollView.leadingAnchor
        menuView.widthAnchor ~= width
    }
}
