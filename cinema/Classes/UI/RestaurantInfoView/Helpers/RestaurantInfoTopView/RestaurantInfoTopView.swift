//
//  RestaurantInfoTopView.swift
//  foodle
//
//  Created by incetro on 08/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - RestaurantInfoTopView

class RestaurantInfoTopView: ShadowView {

    private static let offset: CGFloat = 10

    let nameLabel = UILabel(frame: .zero)
    let addressLabel = UILabel(frame: .zero)

    private let imageView = UIImageView(frame: .zero)
    private var button = UIButton(frame: .zero)

    private var buttonType: ButtonTableType?

    weak var delegate: RestaurantInfoViewDelegate?

    func configure(withName name: String, address: String, button: ButtonTableType, image: String) {

        addressLabel.text = address
        nameLabel.text = name

        let url = URL(string: image)
        imageView.kf.setImage(with: url)

        setupButton(button)
    }

    func setup(inView view: UIView) {

        view.addSubview(self)

        layer.cornerRadius = 5

        translatesAutoresizingMaskIntoConstraints = false

        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: RestaurantInfoTopView.offset).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -RestaurantInfoTopView.offset).isActive = true
        heightAnchor.constraint(equalToConstant: 108).isActive = true

        backgroundColor = .white

        setupImageView()
        setupNameLabel()
        setupAddressLabel()
    }

    func updateButtonType(_ type: ButtonTableType) {

        button.removeTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        setupButton(type)
    }

    func buttonTapped() {

        guard let type = buttonType else {

            return
        }

        delegate?.didTapTableButton(type)
    }

    private func setupButton(_ buttonType: ButtonTableType) {

        self.buttonType = buttonType
        button = buttonType.button

        addSubview(button)

        button.translatesAutoresizingMaskIntoConstraints = false
        button.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 18).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -11).isActive = true
        button.heightAnchor.constraint(equalToConstant: 26).isActive = true
        button.widthAnchor.constraint(equalToConstant: buttonType.width).isActive = true

        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    private func setupAddressLabel() {

        addSubview(addressLabel)

        addressLabel.textColor = UIColor.fdlGreyishBrown
        addressLabel.font = UIFont.fdlSystemRegular(size: 15)
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 18).isActive = true
        addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 6).isActive = true
        addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4).isActive = true
    }

    private func setupNameLabel() {

        addSubview(nameLabel)

        nameLabel.textColor = UIColor.fdlGreyishBrown
        nameLabel.font = UIFont.fdlGothamProMedium(size: 20)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 18).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 19).isActive = true
    }

    private func setupImageView() {

        addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 11).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -11).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        imageView.backgroundColor = UIColor.fdlPaleGrey
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
    }
}
