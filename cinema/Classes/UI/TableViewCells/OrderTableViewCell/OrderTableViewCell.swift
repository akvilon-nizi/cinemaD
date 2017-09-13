//
//  OrderTableViewCell.swift
//  foodle
//
//  Created by Mac on 07.09.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    private weak var output: OrdersDisplayItemOutput?

    private let container = UIView()
    private let shadowView = ShadowView()

    private let typeView = UIView()
    private let nameLabel = UILabel()
    private let addressLabel = UILabel()
    private let timeLabel = UILabel()
    private let numberLabel = UILabel()
    private let costLabel = UILabel()

    private let hIndent: CGFloat = 19
    private let lIndent: CGFloat = 10

    required init?(coder _: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        shadowView.backgroundColor = .white
        contentView.addSubview(shadowView.prepareForAutoLayout())
        shadowView.pinEdgesToSuperviewEdges(top: 4, left: 10, right: 10, bottom: 4)

        container.backgroundColor = .clear
        contentView.addSubview(container.prepareForAutoLayout())
        container.pinEdgesToSuperviewEdges(top: 4, left: 10, right: 10, bottom: 4)

        container.clipsToBounds = true
        container.layer.cornerRadius = 6.0

        container.addSubview(typeView.prepareForAutoLayout())
        typeView.topAnchor ~= container.topAnchor
        typeView.leadingAnchor ~= container.leadingAnchor
        typeView.bottomAnchor ~= container.bottomAnchor
        typeView.widthAnchor ~= 6

        nameLabel.font = .fdlGothamProMedium(size: 17)
        nameLabel.textColor = .fdlGreyishBrown
        container.addSubview(nameLabel.prepareForAutoLayout())
        nameLabel.topAnchor ~= container.topAnchor + 13
        nameLabel.leadingAnchor ~= container.leadingAnchor + hIndent

        addressLabel.font = .fdlSystemRegular(size: 15)
        addressLabel.textColor = .fdlGreyishBrown
        container.addSubview(addressLabel.prepareForAutoLayout())
        addressLabel.topAnchor ~= nameLabel.bottomAnchor + 7
        addressLabel.leadingAnchor ~= container.leadingAnchor + hIndent

        timeLabel.font = .fdlSystemRegular(size: 13)
        timeLabel.textColor = .fdlWarmGrey
        container.addSubview(timeLabel.prepareForAutoLayout())
        timeLabel.bottomAnchor ~= container.bottomAnchor - 10
        timeLabel.leadingAnchor ~= container.leadingAnchor + hIndent

        numberLabel.font = .fdlGothamProMedium(size: 12)
        numberLabel.textColor = .fdlWarmGrey
        container.addSubview(numberLabel.prepareForAutoLayout())
        numberLabel.topAnchor ~= container.topAnchor + 16
        numberLabel.trailingAnchor ~= container.trailingAnchor - lIndent

        costLabel.font = .fdlSystemRegular(size: 17)
        costLabel.textColor = .fdlGreyishBrown
        container.addSubview(costLabel.prepareForAutoLayout())
        costLabel.bottomAnchor ~= container.bottomAnchor - 10
        costLabel.trailingAnchor ~= container.trailingAnchor - lIndent
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)

        container.backgroundColor = highlighted ? .fdlWhite : .white
    }

    func update(with item: OrdersDisplayItem) {
        if let restaurantItem = item as? OrdersDisplayItemOutput {
            output = restaurantItem
        }

        nameLabel.text = item.name
        addressLabel.text = item.address
        timeLabel.text = item.dateWithPerson
        numberLabel.text = item.typeWithNumber
        costLabel.text = item.price
        typeView.backgroundColor = UIColor.fdlSalmonPink
    }

    // MARK: - Actions

    func handleTapOnCard() {
//        output?.needOpenRestaurant()
    }

    func handleTableButtonPressed() {
//        output?.needCheckTableInRestaurant()
    }
}
