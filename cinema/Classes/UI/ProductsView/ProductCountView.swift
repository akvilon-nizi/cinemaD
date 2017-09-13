//
//  ProductCountView.swift
//  foodle
//
//  Created by incetro on 10/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - ProductCountViewDelegate

protocol ProductCountViewDelegate: class {

    func plusButtonTapped()

    func minusButtonTapped()
}

// MARK: - ProductCountView

class ProductCountView: UIView {

    weak var delegate: ProductCountViewDelegate?

    private let countLabel = UILabel(frame: .zero)
    private let plusButton = UIButton(frame: .zero)
    private let minusButton = UIButton(frame: .zero)

    private let spinner: SpinnerView = {

        let spinner = SpinnerView(frame: .zero)

        spinner.isHidden = true

        return spinner
    }()

    var count: Int = 0 {

        didSet {

            countLabel.text = "\(count)"

            stopSpinning()
        }
    }

    func setup() {

        setupPlusButton()
        setupMinusButton()
        setupCountLabel()
        setupSpinnerView()
    }

    func didTapPlusButton() {

        startSpinning()

        delegate?.plusButtonTapped()
    }

    func didTapMinusButton() {

        startSpinning()

        delegate?.minusButtonTapped()
    }

    func startSpinning() {

        plusButton.isHidden = true
        minusButton.isHidden = true
        countLabel.isHidden = true

        spinner.start()
    }

    func stopSpinning() {

        plusButton.isHidden = false
        minusButton.isHidden = false
        countLabel.isHidden = false

        spinner.stop()
    }

    private func setupSpinnerView() {

        addSubview(spinner.prepareForAutoLayout())

        spinner.centerXAnchor ~= countLabel.centerXAnchor
        spinner.centerYAnchor ~= countLabel.centerYAnchor
        spinner.heightAnchor ~= 30
        spinner.widthAnchor ~= spinner.heightAnchor
    }

    private func setupCountLabel() {

        addSubview(countLabel)

        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.leadingAnchor ~= minusButton.trailingAnchor
        countLabel.trailingAnchor ~= plusButton.leadingAnchor
        countLabel.centerXAnchor ~= centerXAnchor
        countLabel.centerYAnchor ~= centerYAnchor
        countLabel.textAlignment = .center
        countLabel.font = UIFont.fdlSystemRegular(size: 12)
    }

    private func setupPlusButton() {

        addSubview(plusButton)

        plusButton.setImage(Asset.Cart.cartPlus.image, for: .normal)

        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.trailingAnchor ~= trailingAnchor - 5
        plusButton.topAnchor ~= topAnchor + 5
        plusButton.bottomAnchor ~= bottomAnchor - 5
        plusButton.widthAnchor ~= plusButton.heightAnchor

        plusButton.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        plusButton.layer.cornerRadius = 2
    }

    private func setupMinusButton() {

        addSubview(minusButton)

        minusButton.setImage(Asset.Cart.cartMinus.image, for: .normal)

        minusButton.translatesAutoresizingMaskIntoConstraints = false
        minusButton.leadingAnchor ~= leadingAnchor + 5
        minusButton.topAnchor ~= topAnchor + 5
        minusButton.bottomAnchor ~= bottomAnchor - 5
        minusButton.widthAnchor ~= minusButton.heightAnchor
        minusButton.addTarget(self, action: #selector(didTapMinusButton), for: .touchUpInside)
        minusButton.layer.cornerRadius = 2
    }
}
