//
//  MainTabView.swift
//  cinema
//
//  Created by User on 08.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

protocol MainTabViewDelegate: class {

    func ticketsTapped()

    func rewardsTapped()

    func profileTapped()

    func chatTapped()

    func kinobaseTapped()
}

class MainTabView: UIView {

    let ticketsButton = UIButton()
    let rewardsButton = UIButton()
    let profileButton = UIButton()
    let chatButton = UIButton()
    let kinobaseButton = UIButton()

    weak var delegate: MainTabViewDelegate?

    override init(frame: CGRect) {

        super.init(frame: frame)

        ticketsButton.setImage(Asset.Cinema.MainTab.tickets.image, for: .normal)
        ticketsButton.heightAnchor ~= 19
        ticketsButton.widthAnchor ~= 30
        ticketsButton.addTarget(self, action: #selector(ticketsTapped), for: .touchUpInside)

        rewardsButton.setImage(Asset.Cinema.MainTab.reward.image, for: .normal)
        rewardsButton.heightAnchor ~= 25
        rewardsButton.widthAnchor ~= 26
        rewardsButton.addTarget(self, action: #selector(rewardsTapped), for: .touchUpInside)

        profileButton.heightAnchor ~= 60
        profileButton.backgroundColor = UIColor.cnmGreyLight
        profileButton.widthAnchor ~= 60
        profileButton.layer.cornerRadius = 30
        profileButton.addTarget(self, action: #selector(profileTapped), for: .touchUpInside)

        chatButton.setImage(Asset.Cinema.MainTab.chat.image, for: .normal)
        chatButton.heightAnchor ~= 21
        chatButton.widthAnchor ~= 27
        chatButton.addTarget(self, action: #selector(chatTapped), for: .touchUpInside)

        kinobaseButton.setImage(Asset.Cinema.MainTab.kinobase.image, for: .normal)
        kinobaseButton.heightAnchor ~= 21
        kinobaseButton.widthAnchor ~= 25
        kinobaseButton.addTarget(self, action: #selector(kinobaseTapped), for: .touchUpInside)

        let backgroundImage = UIImageView(image: Asset.Cinema.MainTab.tabBackground.image)
        backgroundImage.contentMode = .scaleToFill
        backgroundImage.layer.masksToBounds = true
        addSubview(backgroundImage.prepareForAutoLayout())
        backgroundImage.topAnchor ~= topAnchor - 50
        backgroundImage.bottomAnchor ~= bottomAnchor + 50
        backgroundImage.leadingAnchor ~= leadingAnchor
        backgroundImage.trailingAnchor ~= trailingAnchor

        let stackView = createStackView(.horizontal, .center, .fillEqually, 20.0,
                                        with: [ticketsButton, rewardsButton, profileButton, chatButton, kinobaseButton])

        addSubview(stackView.prepareForAutoLayout())
        stackView.pinEdgesToSuperviewEdges()
    }

    @objc func ticketsTapped() {
        delegate?.ticketsTapped()
    }

    @objc func rewardsTapped() {
        delegate?.rewardsTapped()
    }

    @objc func profileTapped() {
        delegate?.profileTapped()
    }

    @objc func chatTapped() {
        delegate?.chatTapped()
    }

    @objc func kinobaseTapped() {
        delegate?.kinobaseTapped()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
