//
//  RestaurantViewAnimator.swift
//  foodle
//
//  Created by incetro on 11/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - RestaurantViewAnimator

class RestaurantViewAnimator: NSObject {

    var scrollView: UIScrollView? {

        didSet {

            scrollView?.delegate = self
        }
    }

    var navigationBarView: RestaurantNavigationBarView?
    var imageView: UIImageView?
}

// MARK: - UIScrollViewDelegate

extension RestaurantViewAnimator: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        imageView?.constraint(withIdentifier: "ID")?.constant = max(133 - ((scrollView.contentOffset.y / 42.0) * 69), 64)

        navigationBarView?.updateAlpha(withOffset: scrollView.contentOffset.y)

        imageView?.alpha = 1 - (navigationBarView?.alpha ?? 0)
    }
}
