//
//  CollectionCell.swift
//  cinema
//
//  Created by User on 02.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

protocol CollectionCellDelegate: class {
    func tapButtonSetting(_ index: Int)
}

// MARK: - CollectionCell

class CollectionCell: UITableViewCell {

//    let selectColor = UIColor(white: 87.0 / 255.0, alpha: 1.0)
//    let unSelectColor = UIColor.cnmAfafaf

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFutura(size: 19)
        label.textColor = UIColor.cnmAfafaf
//        label.text = "sdofnkalsfna"
        return label
    }()

    private let button = UIButton()

    var indexPath: Int = 0

    weak var delegate: CollectionCellDelegate?

    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }

    required init?(coder _: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        contentView.addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.centerYAnchor ~= centerYAnchor
        titleLabel.leadingAnchor ~= leadingAnchor + 34

        button.setImage(Asset.Kinobase.settingsUnselect.image, for: .normal)
        contentView.addSubview(button.prepareForAutoLayout())
        button.centerYAnchor ~= centerYAnchor
        button.trailingAnchor ~= trailingAnchor - 40
        button.addTarget(self, action: #selector(tapSettings), for: .touchUpInside)

        let separatorView = UIView()
        separatorView.backgroundColor = .cnmDadada
        contentView.addSubview(separatorView.prepareForAutoLayout())
        separatorView.bottomAnchor ~= bottomAnchor
        separatorView.trailingAnchor ~= trailingAnchor - 24
        separatorView.leadingAnchor ~= leadingAnchor + 24
        separatorView.heightAnchor ~= 1
    }

    override func layoutSubviews() {

        super.layoutSubviews()

//        selectionStyle = .none
//        backgroundColor = .clear
//
//        contentView.addSubview(backView)
//        contentView.backgroundColor = .clear
//
//        backView.shadowOpacity = 0.25
//        backView.backgroundColor = .white
//        backView.translatesAutoresizingMaskIntoConstraints = false
//        backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
//        backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
//        backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4).isActive = true
//        backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4).isActive = true
//
//        backView.addSubview(itemImageView)
//
//        itemImageView.translatesAutoresizingMaskIntoConstraints = false
//        itemImageView.backgroundColor = .black
//        itemImageView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 14).isActive = true
//        itemImageView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 10).isActive = true
//        itemImageView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -10).isActive = true
//        itemImageView.widthAnchor.constraint(equalTo: itemImageView.heightAnchor).isActive = true
//
//        backView.addSubview(arrowImageView)
//
//        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
//        arrowImageView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -14).isActive = true
//        arrowImageView.centerYAnchor.constraint(equalTo: backView.centerYAnchor).isActive = true
//
//        let arrowImage = Asset.Restaurant.restaurantMenuArrow.image
//
//        let templateImage = arrowImage.withRenderingMode(.alwaysTemplate)
//        arrowImageView.image = templateImage
//        arrowImageView.tintColor = UIColor.fdlPinkishGrey
//
//        backView.addSubview(itemNameLabel)
//
//        itemNameLabel.font = UIFont.fdlSystemRegular(size: 15)
//        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
//        itemNameLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 18).isActive = true
//        itemNameLabel.centerYAnchor.constraint(equalTo: backView.centerYAnchor).isActive = true
//        itemNameLabel.trailingAnchor ~= backView.trailingAnchor - 25
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        titleLabel.textColor = !selected ? UIColor.cnmAfafaf : UIColor(white: 87.0 / 255.0, alpha: 1.0)

        if selected {
            button.setImage(Asset.Kinobase.settings.image, for: .normal)
        } else {
            button.setImage(Asset.Kinobase.settingsUnselect.image, for: .normal)
        }

        contentView.backgroundColor = .white
    }

    // MARK: Actions
    func tapSettings() {
        delegate?.tapButtonSetting(indexPath)
    }

    static var reuseIdentifier: String {
        return "CollectionCell"
    }
}
