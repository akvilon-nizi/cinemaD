//
//  ViewHelpers.swift
//  cinema
//
//  Created by Mac on 15.09.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - reusable functions

func createStackView(
    _ axis: UILayoutConstraintAxis,
    _ alignment: UIStackViewAlignment?,
    _ distribution: UIStackViewDistribution?,
    _ spacing: CGFloat,
    with subviews: [UIView]
    ) -> UIStackView {
    let stackView = UIStackView()
    stackView.axis = axis
    stackView.spacing = spacing
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.alignment = alignment ?? .fill
    stackView.distribution = distribution ?? .fill

    subviews.forEach { subview in
        stackView.addArrangedSubview(subview)
    }

    return stackView
}

// MARK: - Extensions

extension UITableViewCell {
    class func ins_defaultReuseIdentifier() -> String {
        return String(describing: self)
    }

    class func ins_defaultNib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
