//
// Created by Александр Масленников on 15.08.17.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    private weak var output: RestaurantsDisplayItemOutput?

    private let container = ShadowView()

    private let nameLabel = UILabel()
    private let addressLabel = UILabel()
    private let ratingStarView = RatingStarView()
    private let tableButton = ButtonTableType.check.button
    private let logoImageView = ImageView()

    private let hIndent: CGFloat = 12

    required init?(coder _: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapOnCard))

        container.addGestureRecognizer(tap)
        container.backgroundColor = .white
        contentView.addSubview(container.prepareForAutoLayout())
        container.pinEdgesToSuperviewEdges(top: 4, left: 10, right: 10, bottom: 4)

        nameLabel.font = .fdlGothamProMedium(size: 17)
        nameLabel.textColor = .fdlGreyishBrown
        container.addSubview(nameLabel.prepareForAutoLayout())
        nameLabel.topAnchor ~= container.topAnchor + 18
        nameLabel.leadingAnchor ~= container.leadingAnchor + hIndent

        addressLabel.font = .fdlSystemRegular(size: 15)
        addressLabel.textColor = .fdlGreyishBrown
        container.addSubview(addressLabel.prepareForAutoLayout())
        addressLabel.topAnchor ~= nameLabel.bottomAnchor + 7
        addressLabel.leadingAnchor ~= container.leadingAnchor + hIndent

        ratingStarView.setContentCompressionResistancePriority(800, for: .horizontal)
        container.addSubview(ratingStarView.prepareForAutoLayout())
        ratingStarView.leadingAnchor ~= container.leadingAnchor + hIndent
        ratingStarView.bottomAnchor ~= container.bottomAnchor - 10

        tableButton.addTarget(self, action: #selector(handleTableButtonPressed), for: .touchUpInside)
        container.addSubview(tableButton.prepareForAutoLayout())
        tableButton.leadingAnchor >= ratingStarView.trailingAnchor + hIndent
        tableButton.bottomAnchor ~= container.bottomAnchor - 10
        tableButton.widthAnchor ~= ButtonTableType.check.width

        logoImageView.isRounded = true
        container.addSubview(logoImageView.prepareForAutoLayout())
        logoImageView.centerYAnchor ~= container.centerYAnchor
        logoImageView.leadingAnchor ~= nameLabel.trailingAnchor + hIndent
        logoImageView.leadingAnchor ~= addressLabel.trailingAnchor + hIndent
        logoImageView.leadingAnchor ~= tableButton.trailingAnchor + 15
        logoImageView.trailingAnchor ~= container.trailingAnchor - 10
        logoImageView.widthAnchor ~= 86
        logoImageView.heightAnchor ~= logoImageView.widthAnchor
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)

        container.backgroundColor = highlighted ? .fdlWhite : .white
    }

    func update(with item: RestaurantsDisplayItem) {
        if let restaurantItem = item as? RestaurantsDisplayItemOutput {
            output = restaurantItem
        }

        nameLabel.text = item.name
        addressLabel.text = item.address
        ratingStarView.text = item.rating
        logoImageView.setImage(with: item.image)
    }

    // MARK: - Actions

    func handleTapOnCard() {
        output?.needOpenRestaurant()
    }

    func handleTableButtonPressed() {
        output?.needCheckTableInRestaurant()
    }
}
