//
//  ProfileHeader.swift
//  cinema
//
//  Created by iOS on 24.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

protocol ProfileHeaderDelegate: class {
    func tapEdit()
    func tapSettings()
    func tapButton(tag: Int)
}

class ProfileHeader: UITableViewHeaderFooterView {

    weak var delegate: ProfileHeaderDelegate?

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFuturaLight(size: 18)
        label.textColor = UIColor.cnmGreyLight
        label.text = "Анна Каренина"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.widthAnchor ~= 128
        return label
    }()

    private let editButton: UIButton = {
        let button = UIButton()
        button.heightAnchor ~= 31
        button.widthAnchor ~= 128
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.cnmMainOrange.cgColor
        button.layer.borderWidth = 1.0
        button.backgroundColor = .white
        button.setTitle(L10n.profileEditingProfile, for: .normal)
        button.setTitleColor(UIColor.cnmMainOrange, for: .normal)
        button.titleLabel?.font = UIFont.cnmFuturaLight(size: 14)
        return button
    }()

    private let settingsButton: UIButton = {
        let button = UIButton()
        button.heightAnchor ~= 24
        button.widthAnchor ~= 24
        button.setImage(Asset.Cinema.Profile.settingsOrange.image, for: .normal)
        return button
    }()

    private let userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.heightAnchor ~= 92
        imageView.widthAnchor ~= 92
        imageView.backgroundColor = UIColor.cnm3a3a3a
        imageView.layer.cornerRadius = 92 / 2
        imageView.layer.masksToBounds = true
        imageView.image = Asset.Cinema.Profile.userPlaceholder.image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    let watchView = ProfileHeaderView()

    let rewardsView = ProfileHeaderView(true)

    let friendsView = ProfileHeaderView()

    let stackView = UIView()

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = .white

        autoresizesSubviews = true

    }

    private func setStackView(profile: ProfileModel) {

        watchView.setParameters(
            topLabelText: L10n.profileWatchText,
            bottomLabelText: String(profile.watched),
            image: Asset.Cinema.Profile.watchProfile.image)

        rewardsView.setParameters(
            topLabelText: L10n.profileRewardsText,
            bottomLabelText: String(profile.rewards),
            image: Asset.Cinema.Profile.rewardsProfile.image)
        rewardsView.tag = 1

        friendsView.setParameters(
            topLabelText: L10n.profileFriendText,
            bottomLabelText: String(profile.friends),
            image: Asset.Cinema.Profile.friendsProfile.image)
        friendsView.tag = 2

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        watchView.addGestureRecognizer(tap)
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        rewardsView.addGestureRecognizer(tap2)
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        friendsView.addGestureRecognizer(tap3)

        let stack = createStackView(.horizontal, .fill, .fill, 0, with: [watchView, rewardsView, friendsView])

        stackView.addSubview(stack.prepareForAutoLayout())
        stack.pinEdgesToSuperviewEdges()
    }

// MARK: - Actions

    func handleTap(sender: UITapGestureRecognizer) {
        if let view = sender.view {
            delegate?.tapButton(tag: view.tag)
        }
    }

    func handleTapEditButton() {
        delegate?.tapEdit()
    }

    func handleTapSettingsButton() {
        delegate?.tapSettings()
    }

    func setProfileInfo(profile: ProfileModel) {
        let mainView = UIView()
        contentView.addSubview(mainView.prepareForAutoLayout())
        mainView.topAnchor ~= contentView.topAnchor + 19
        mainView.centerXAnchor ~= contentView.centerXAnchor
        mainView.bottomAnchor ~= contentView.bottomAnchor + 20

        mainView.addSubview(userImage.prepareForAutoLayout())
        userImage.topAnchor ~= mainView.topAnchor
        userImage.leadingAnchor ~= mainView.leadingAnchor + 15
        userImage.kf.setImage(with: URL(string: profile.avatar))

        mainView.addSubview(editButton.prepareForAutoLayout())
        editButton.topAnchor ~= userImage.bottomAnchor - 40
        editButton.addTarget(self, action: #selector(handleTapEditButton), for: .touchUpInside)

        mainView.addSubview(nameLabel.prepareForAutoLayout())
        nameLabel.bottomAnchor ~= userImage.bottomAnchor - 52
        nameLabel.leadingAnchor ~= editButton.leadingAnchor
        nameLabel.text = profile.name

        mainView.addSubview(settingsButton.prepareForAutoLayout())
        settingsButton.leadingAnchor ~= editButton.trailingAnchor + 8
        settingsButton.centerYAnchor ~= editButton.centerYAnchor
        settingsButton.trailingAnchor ~= mainView.trailingAnchor - 15
        settingsButton.addTarget(self, action: #selector(handleTapSettingsButton), for: .touchUpInside)

        mainView.addSubview(stackView.prepareForAutoLayout())
        stackView.topAnchor ~= userImage.bottomAnchor + 23
        stackView.leadingAnchor ~= mainView.leadingAnchor
        stackView.trailingAnchor ~= mainView.trailingAnchor
        stackView.heightAnchor ~= 43

        setStackView(profile: profile)
    }

    func reloadData(_ profile: ProfileModel) {
        userImage.kf.setImage(with: URL(string: profile.avatar))
        nameLabel.text = profile.name

        watchView.setCount(text: String(profile.watched))

        rewardsView.setCount(text: String(profile.rewards))

        friendsView.setCount(text: String(profile.friends))
    }

    func editeProfile(name: String, imageUrl: String) {
        userImage.kf.setImage(with: URL(string: imageUrl))
        nameLabel.text = name
    }
}
