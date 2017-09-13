//
//  RestaurantInfoView.swift
//  foodle
//
//  Created by incetro on 07/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

struct RestaurantInfoData {

    let name: String
    let address: String
    let buttonType: ButtonTableType
    let image: String
    let rating: String
    let remainingTime: String
    let openingTime: String
    let price: String
}

// MARK: - RestaurantInfoView

class RestaurantInfoView: UIView {

    private let bottomView = RestaurantInfoBottomView(frame: .zero)
    private let topView = RestaurantInfoTopView(frame: .zero)

    var restaurantName: String {

        return topView.nameLabel.text ?? ""
    }

    var restaurantAddress: String {

        return topView.addressLabel.text ?? ""
    }

    func setButtonDelegate(_ delegate: RestaurantInfoViewDelegate) {

        topView.delegate = delegate
    }

    init() {

        super.init(frame: .zero)

        topView.setup(inView: self)
        bottomView.setup(inView: self)
    }

    func configure(withData data: RestaurantInfoData) {

        topView.configure(withName: data.name, address: data.address, button: data.buttonType, image: data.image)
        bottomView.configure(withRating: data.rating, remainingTime: data.remainingTime, openingTime: data.openingTime, price: data.price)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol RestaurantInfoViewDelegate: class {

    func didTapTableButton(_ type: ButtonTableType)
}
