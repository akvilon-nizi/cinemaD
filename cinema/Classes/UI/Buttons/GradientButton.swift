//
// Created by Александр Масленников on 28.08.17.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class GradientButton: UIButton {

    private let colorLeft: UIColor = .fdlWatermelon
    private let colorRight: UIColor = .fdlPeachyPink

    private let gradient = CAGradientLayer()

    required init(coder _: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        titleLabel?.font = .fdlGothamProMedium(size: 15)
        titleLabel?.textColor = .white
        layer.cornerRadius = 5
        clipsToBounds = true

        gradient.colors = [colorLeft.cgColor, colorRight.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.05)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.05)
        layer.insertSublayer(gradient, at: 0)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        gradient.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
    }

    override var isEnabled: Bool {
        didSet {
            let alpha: CGFloat = isEnabled ? 1 : 0.5
            gradient.colors = [
                colorLeft.withAlphaComponent(alpha).cgColor,
                colorRight.withAlphaComponent(alpha).cgColor
            ]
        }
    }
}
