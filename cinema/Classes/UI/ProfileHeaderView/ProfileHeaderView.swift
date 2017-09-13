//
//  ProfileHeaderView.swift
//  foodle
//
//  Created by incetro on 25/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - ProfileHeaderView

class ProfileHeaderView: UIView {

    private static let userImageSize: CGFloat = 76
    static let height: CGFloat = 150

    weak var delegate: ProfileHeaderViewDelegate?

    let userImageView: UIImageView = {

        let userImageView = UIImageView()

        userImageView.clipsToBounds = true
        userImageView.layer.borderColor = UIColor.white.cgColor
        userImageView.layer.borderWidth = 4
        userImageView.contentMode = .scaleAspectFill

        return userImageView
    }()

    private let backgroundImageView: UIImageView = {

        let backgroundImageView = UIImageView(image: Asset.Profile.profileHeader.image)

        return backgroundImageView
    }()

    fileprivate let alphaView: UIView = {

        let alphaView = UIView()

        alphaView.backgroundColor = UIColor(white: 111.0 / 255.0, alpha: 0.8)
        alphaView.layer.borderColor = UIColor.white.cgColor
        alphaView.layer.borderWidth = 4
        alphaView.alpha = 0.55

        return alphaView
    }()

    override init(frame: CGRect) {

        super.init(frame: frame)

        setupBackgroundView()
        setupUserImageView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {

        super.layoutSubviews()

        userImageView.layer.cornerRadius = userImageView.frame.height * 0.5
        alphaView.layer.cornerRadius = alphaView.frame.height * 0.5
    }

    func setupAvatarButton() {

        addSubview(alphaView.prepareForAutoLayout())

        alphaView.pin(to: userImageView)

        let imageView = UIImageView(image: Asset.Profile.profileCamera.image)

        addSubview(imageView.prepareForAutoLayout())

        imageView.centerXAnchor ~= userImageView.centerXAnchor
        imageView.centerYAnchor ~= userImageView.centerYAnchor
        imageView.heightAnchor ~= 26
        imageView.widthAnchor ~= 30

        let button = UIButton()

        button.clipsToBounds = true

        addSubview(button.prepareForAutoLayout())

        button.pin(to: userImageView)
        button.addTarget(self, action: #selector(didTapOnAvatar), for: .touchUpInside)

        layoutSubviews()
    }

    func didTapOnAvatar() {

        delegate?.didTapOnAvatar()
    }

    private func setupBackgroundView() {

        addSubview(backgroundImageView.prepareForAutoLayout())

        backgroundImageView.pinEdgesToSuperviewEdges(withOffset: -5)
    }

    private func setupUserImageView() {

        addSubview(userImageView.prepareForAutoLayout())

        userImageView.centerXAnchor ~= backgroundImageView.centerXAnchor
        userImageView.widthAnchor ~= userImageView.heightAnchor
        userImageView.topAnchor ~= backgroundImageView.topAnchor + 35
        userImageView.bottomAnchor ~= backgroundImageView.bottomAnchor - 35
    }
}
