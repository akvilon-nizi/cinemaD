//
//  FriendsAddCell.swift
//  cinema
//
//  Created by iOS on 11.12.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

protocol FriendsAddCellDelegate: class {
    func tapButtonChat(_ index: Int)
}

// MARK: - FriendsListCell

class FriendsAddCell: UITableViewCell {

    weak var delegate: FriendsAddCellDelegate?

    private let titleLabel: UILabel = {
        let label = UILabel()
        let size: CGFloat = UIWindow(frame: UIScreen.main.bounds).bounds.width == 320 ? 14 : 18
        label.font = UIFont.cnmFuturaLight(size: size)
        label.textColor = UIColor.cnmBlue
        label.numberOfLines = 3
        return label
    }()

    private let userImage: UIImageView = {
        let image = UIImageView()
        image.heightAnchor ~= 55
        image.widthAnchor ~= 55
        image.layer.cornerRadius = 55 / 2
        image.layer.masksToBounds = true
        image.image = Asset.Cinema.Profile.userPlaceholder.image
        return image
    }()

    private let addButton: UIButton = {
        let button = UIButton()
        button.heightAnchor ~= 31
        let width: CGFloat = UIWindow(frame: UIScreen.main.bounds).bounds.width == 320 ? 90 : 110
        button.widthAnchor ~= width
        button.setTitle("Добавить", for: .normal)
        button.titleLabel?.font = .cnmFuturaLight(size: 12)
        button.setTitleColor(UIColor.cnmMainOrange, for: .normal)
        button.setTitleColor(UIColor.cnmGreyColor, for: .disabled)
        button.layer.cornerRadius = 5.0
        button.layer.borderColor = UIColor.cnmMainOrange.cgColor
        button.layer.borderWidth = 1.0
        button.backgroundColor = .white
        return button
    }()

    var name: String = "" {
        didSet {
            titleLabel.text = name
        }
    }

    var linkImage: String = "" {
        didSet {
            userImage.kf.indicatorType = .activity
            userImage.kf.setImage(with: URL(string: linkImage))
        }
    }

    var index: Int = 0

    var buttonIsEnabled = true {
        didSet {
            if buttonIsEnabled {
//                addButton.layer.borderColor = UIColor.cnmMainOrange.cgColor
//                addButton.isEnabled = true
                addButton.isHidden = false
            } else {
//                addButton.layer.borderColor = UIColor.cnmGreyColor.cgColor
//                addButton.isEnabled = false
                addButton.isHidden = true
            }
        }
    }

    required init?(coder _: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        let leading: CGFloat = UIWindow(frame: UIScreen.main.bounds).bounds.width == 320 ? 20 : 27
        let trailing: CGFloat = UIWindow(frame: UIScreen.main.bounds).bounds.width == 320 ? 25 : 40

        contentView.addSubview(userImage.prepareForAutoLayout())
        userImage.centerYAnchor ~= contentView.centerYAnchor
        userImage.leadingAnchor ~= contentView.leadingAnchor + leading

        contentView.addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.centerYAnchor ~= centerYAnchor
        titleLabel.leadingAnchor ~= userImage.trailingAnchor + 13

        contentView.addSubview(addButton.prepareForAutoLayout())
        addButton.centerYAnchor ~= centerYAnchor
        addButton.trailingAnchor ~= trailingAnchor - trailing
        addButton.addTarget(self, action: #selector(chatButtonHandlerTap), for: .touchUpInside)

        contentView.addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.centerYAnchor ~= centerYAnchor
        titleLabel.leadingAnchor ~= userImage.trailingAnchor + 34
        titleLabel.trailingAnchor ~= addButton.leadingAnchor - 10

        let separatorView = UIView()
        separatorView.backgroundColor = .cnmDadada
        contentView.addSubview(separatorView.prepareForAutoLayout())
        separatorView.bottomAnchor ~= contentView.bottomAnchor
        separatorView.trailingAnchor ~= contentView.trailingAnchor - 24
        separatorView.leadingAnchor ~= titleLabel.leadingAnchor
        separatorView.heightAnchor ~= 1
    }

    func setUserInfo(name: String, imageLink: String) {

    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.backgroundColor = .white
    }

    // MARK: Actions
    func chatButtonHandlerTap() {
        delegate?.tapButtonChat(index)
    }

    static var reuseIdentifier: String {
        return "FriendsAddCell"
    }
}
