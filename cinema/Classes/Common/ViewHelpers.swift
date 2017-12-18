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

extension String {
    func setPriceMask() -> String {
        var resultString = String()
        self.enumerated().forEach { index, character in

            // Add space every 4 characters

            if (self.count - index) % 3 == 0 && index > 0 {
                resultString += " "
            }
            resultString.append(character)
        }
        return resultString
    }
}

extension UIButton {
    func inviteButton() -> UIButton {
        self.setTitle(L10n.filmInviteFilm, for: .normal)
        self.setTitleColor(UIColor.cnmMainOrange, for: .normal)
        self.titleLabel?.font = UIFont.cnmFutura(size: 16)
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 5.0
        self.layer.borderColor = UIColor.cnmMainOrange.cgColor
        self.layer.borderWidth = 1.0
        self.heightAnchor ~= 53
        self.widthAnchor ~= 182
        return self
    }
}
