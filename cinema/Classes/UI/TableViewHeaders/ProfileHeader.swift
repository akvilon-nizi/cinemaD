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
        imageView.image = Asset.Cinema.Profile.userPlaceholder.image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    let stackView = UIView()

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = .white

        autoresizesSubviews = true

        let mainView = UIView()
        contentView.addSubview(mainView.prepareForAutoLayout())
        mainView.topAnchor ~= contentView.topAnchor + 19
        mainView.leadingAnchor ~= contentView.leadingAnchor + 53
        mainView.trailingAnchor ~= contentView.trailingAnchor - 53
        mainView.bottomAnchor ~= contentView.bottomAnchor + 20

        mainView.addSubview(userImage.prepareForAutoLayout())
        userImage.topAnchor ~= mainView.topAnchor
        userImage.leadingAnchor ~= mainView.leadingAnchor

        mainView.addSubview(nameLabel.prepareForAutoLayout())
        nameLabel.leadingAnchor ~= userImage.trailingAnchor + 21
        nameLabel.bottomAnchor ~= userImage.bottomAnchor - 52

        mainView.addSubview(editButton.prepareForAutoLayout())
        editButton.leadingAnchor ~= userImage.trailingAnchor + 21
        editButton.topAnchor ~= userImage.bottomAnchor - 40
        editButton.addTarget(self, action: #selector(handleTapEditButton), for: .touchUpInside)

        mainView.addSubview(settingsButton.prepareForAutoLayout())
        settingsButton.leadingAnchor ~= editButton.trailingAnchor + 8
        settingsButton.centerYAnchor ~= editButton.centerYAnchor
        settingsButton.addTarget(self, action: #selector(handleTapSettingsButton), for: .touchUpInside)

        mainView.addSubview(stackView.prepareForAutoLayout())
        stackView.topAnchor ~= userImage.bottomAnchor + 23
        stackView.centerXAnchor ~= mainView.centerXAnchor
        stackView.heightAnchor ~= 43

        setStackView()
    }

    func setStackView() {
        let watchView = UIView().setParameters(
            topLabelText: L10n.profileWatchText,
            bottomLabelText: "23",
            image: Asset.Cinema.Profile.watchProfile.image)

        let rewardsView = UIView().setParameters(
            topLabelText: L10n.profileRewardsText,
            bottomLabelText: "117",
            image: Asset.Cinema.Profile.rewardsProfile.image,
            isCenter: true)

        let friendsView = UIView().setParameters(
            topLabelText: L10n.profileFriendText,
            bottomLabelText: "8",
            image: Asset.Cinema.Profile.friendsProfile.image)

        let stack = createStackView(.horizontal, .fill, .fill, 0, with: [watchView, rewardsView, friendsView])

        stackView.addSubview(stack.prepareForAutoLayout())
        stack.pinEdgesToSuperviewEdges()
    }

    //MARK: Actions

    func handleTapEditButton() {
        delegate?.tapEdit()
    }

    func handleTapSettingsButton() {
        delegate?.tapSettings()
    }
}

private extension UIView {
    func setParameters(
        topLabelText: String,
        bottomLabelText: String,
        image: UIImage,
        isCenter: Bool = false) -> UIView {

        let topLabel = UILabel()
        topLabel.text = topLabelText
        topLabel.font = UIFont.cnmFuturaLight(size: 16)
        topLabel.textColor = UIColor.cnmAfafaf
        self.addSubview(topLabel.prepareForAutoLayout())
        topLabel.topAnchor ~= self.topAnchor
        topLabel.centerXAnchor ~= self.centerXAnchor

        let contentView = UIView()
        self.addSubview(contentView.prepareForAutoLayout())
        contentView.centerXAnchor ~= self.centerXAnchor
        contentView.topAnchor ~= topLabel.bottomAnchor + 8
        contentView.bottomAnchor ~= self.bottomAnchor

        let imageView = UIImageView()
        imageView.image = image
        contentView.addSubview(imageView.prepareForAutoLayout())
        imageView.centerYAnchor ~= contentView.centerYAnchor
        imageView.leadingAnchor ~= contentView.leadingAnchor

        let bottomLabel = UILabel()
        bottomLabel.text = bottomLabelText
        bottomLabel.font = UIFont.cnmFuturaLight(size: 17)
        bottomLabel.textColor = UIColor.setColorGray(white: 109)
        contentView.addSubview(bottomLabel.prepareForAutoLayout())
        bottomLabel.centerYAnchor ~= contentView.centerYAnchor
        bottomLabel.trailingAnchor ~= contentView.trailingAnchor
        bottomLabel.leadingAnchor ~= imageView.trailingAnchor + 6

        if isCenter {
            let leftView = UIView().separator()
            self.addSubview(leftView.prepareForAutoLayout())
            leftView.topAnchor ~= self.topAnchor
            leftView.leadingAnchor ~= self.leadingAnchor
            leftView.topAnchor ~= self.topAnchor

            let rightView = UIView().separator()
            self.addSubview(rightView.prepareForAutoLayout())
            rightView.topAnchor ~= self.topAnchor
            rightView.trailingAnchor ~= self.trailingAnchor
            rightView.topAnchor ~= self.topAnchor
        }

        let width = (UIWindow(frame: UIScreen.main.bounds).bounds.width - 54 * 2) / 3

        let widthView = isCenter ? width + 2 : width - 1

        self.widthAnchor ~= widthView
        self.heightAnchor ~= 43

        return self
    }

    func separator() -> UIView {
        self.heightAnchor ~= 43
        self.widthAnchor ~= 1
        self.backgroundColor = UIColor.cnmAfafaf
        return self
    }
}
