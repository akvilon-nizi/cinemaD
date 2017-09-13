//
//  PointDigitView.swift
//  foodle
//
//  Created by incetro on 21/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - PointDigitView

class PointDigitView: UIView {

    private enum Mode {

        case red
        case black
        case digit
    }

    var digit: String {

        return digitLabel.text ?? ""
    }

    private static let pointSize: CGFloat = 14

    private let pointView: UIView = {

        let pointView = UIView()

        pointView.backgroundColor = UIColor.fdlGreyishBrown
        pointView.layer.cornerRadius = pointSize * 0.5
        pointView.clipsToBounds = true

        return pointView
    }()

    private let digitLabel: UILabel = {

        let digitLabel = UILabel()

        digitLabel.font = UIFont.fdlGothamProMedium(size: 20)
        digitLabel.textAlignment = .center
        digitLabel.backgroundColor = .white

        return digitLabel
    }()

    private var mode: Mode = .black

    override init(frame: CGRect) {

        super.init(frame: frame)

        addSubview(digitLabel.prepareForAutoLayout())

        digitLabel.centerXAnchor ~= centerXAnchor
        digitLabel.centerYAnchor ~= centerYAnchor

        addSubview(pointView.prepareForAutoLayout())

        pointView.heightAnchor ~= PointDigitView.pointSize
        pointView.widthAnchor ~= PointDigitView.pointSize
        pointView.centerXAnchor ~= centerXAnchor
        pointView.centerYAnchor ~= centerYAnchor

        digitLabel.isHidden = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setDigit(_ digit: String) {

        guard digit.characters.count == 1 else {

            return
        }

        mode = .digit

        digitLabel.text = digit
        digitLabel.textColor = UIColor.fdlGreyishBrown

        pointView.isHidden = true
        digitLabel.isHidden = false

        turnOff()
    }

    func clear() {

        if mode == .digit {

            digitLabel.text?.removeAll()
            digitLabel.textColor = UIColor.fdlGreyishBrown

            mode = .black

            pointView.isHidden = false
            digitLabel.isHidden = true
        }
    }

    func turnOn() {

        switch mode {

        case .red, .black:
            pointView.backgroundColor = UIColor.fdlSalmonPink

        case .digit:
            digitLabel.textColor = UIColor.fdlSalmonPink
        }
    }

    func turnOff() {

        switch mode {

        case .red, .black:
            pointView.backgroundColor = UIColor.fdlGreyishBrown

        case .digit:
            digitLabel.textColor = UIColor.fdlGreyishBrown
        }
    }
}
