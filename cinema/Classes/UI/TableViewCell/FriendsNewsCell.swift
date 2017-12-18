//
//  FriendsNewsCell.swift
//  cinema
//
//  Created by User on 17.12.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

//protocol FriendsListCellDelegate: class {
//    func tapButtonChat(_ index: Int)
//}

// MARK: - FriendsListCell

class FriendsNewsCell: UITableViewCell {

    weak var delegate: FriendsListCellDelegate?

    private let windowWidth = (UIWindow(frame: UIScreen.main.bounds).bounds.width - 40) / 9 * 4 + 20

    private let titleLabel: UILabel = {
        let label = UILabel()
        let size: CGFloat = UIWindow(frame: UIScreen.main.bounds).bounds.width == 320 ? 14 : 18
        label.font = UIFont.cnmFuturaLight(size: size)
        label.textColor = UIColor.cnmBlue
        label.numberOfLines = 3
        return label
    }()

    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        let size: CGFloat = 14
        label.font = UIFont.cnmFuturaLight(size: size)
        label.textColor = UIColor.setColorGray(white: 61)
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

    private let filmGroup = FilmGroup()

    var name: String = "" {
        didSet {
            titleLabel.text = name
        }
    }

    private let chatButton = UIButton()

    private let button = UIButton()

    var index: Int = 0

    required init?(coder _: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        let leading: CGFloat = UIWindow(frame: UIScreen.main.bounds).bounds.width == 320 ? 20 : 27

        contentView.addSubview(userImage.prepareForAutoLayout())
        userImage.topAnchor ~= contentView.topAnchor + 18
        userImage.leadingAnchor ~= contentView.leadingAnchor + leading

        contentView.addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.centerYAnchor ~= userImage.centerYAnchor
        titleLabel.leadingAnchor ~= userImage.trailingAnchor + 13
        titleLabel.trailingAnchor ~= contentView.trailingAnchor - 10

        contentView.addSubview(newsTitleLabel.prepareForAutoLayout())
        newsTitleLabel.topAnchor ~= userImage.bottomAnchor + 16
        newsTitleLabel.leadingAnchor ~= titleLabel.leadingAnchor

        contentView.addSubview(filmGroup.prepareForAutoLayout())
        filmGroup.heightAnchor ~= windowWidth
        filmGroup.widthAnchor ~= contentView.widthAnchor
        filmGroup.topAnchor ~= newsTitleLabel.bottomAnchor

        let separatorView = UIView()
        separatorView.backgroundColor = .cnmDadada
        contentView.addSubview(separatorView.prepareForAutoLayout())
        separatorView.topAnchor ~= filmGroup.bottomAnchor
        separatorView.bottomAnchor ~= contentView.bottomAnchor
        separatorView.trailingAnchor ~= contentView.trailingAnchor - 24
        separatorView.leadingAnchor ~= titleLabel.leadingAnchor
        separatorView.heightAnchor ~= 1
    }

    func setUserInfo(info: FriendsNewsForView) {
        titleLabel.text = info.name
        userImage.kf.setImage(with: URL(string: info.avatar))
        newsTitleLabel.text = info.type.rawValue
        switch info.type {
        case .watched:
            filmGroup.films = info.todayWatched
        case .willWatch:
            filmGroup.films = info.todayWillWatch
        default:
            return
        }
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
        return "FriendsNewsCell"
    }
}
