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

    lazy var buttons: [UIButton] = [
        self.ticketsButton,
        self.rewardsButton,
        self.profileButton,
        self.chatButton,
        self.kinobaseButton
    ]

    weak var delegate: MainTabViewDelegate?

    override init(frame: CGRect) {

        super.init(frame: frame)

        ticketsButton.setImage(Asset.Cinema.MainTab.Passive.tickets.image, for: .normal)
        ticketsButton.setImage(Asset.Cinema.MainTab.Active.ticketsA.image, for: .selected)
        ticketsButton.heightAnchor ~= 19
        ticketsButton.widthAnchor ~= 30
        ticketsButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)

        rewardsButton.setImage(Asset.Cinema.MainTab.Passive.reward.image, for: .normal)
        rewardsButton.setImage(Asset.Cinema.MainTab.Active.rewardA.image, for: .selected)
        rewardsButton.heightAnchor ~= 25
        rewardsButton.widthAnchor ~= 26
        rewardsButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        rewardsButton.tag = 1

        profileButton.heightAnchor ~= 60
        profileButton.backgroundColor = UIColor.cnmGreyLight
        profileButton.widthAnchor ~= 60
        profileButton.layer.cornerRadius = 30
        profileButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        profileButton.tag = 2

        chatButton.setImage(Asset.Cinema.MainTab.Passive.chat.image, for: .normal)
        chatButton.setImage(Asset.Cinema.MainTab.Active.chatA.image, for: .selected)
        chatButton.heightAnchor ~= 21
        chatButton.widthAnchor ~= 27
        chatButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        chatButton.tag = 3

        kinobaseButton.setImage(Asset.Cinema.MainTab.Passive.kinobase.image, for: .normal)
        kinobaseButton.setImage(Asset.Cinema.MainTab.Active.kinobaseA.image, for: .selected)
        kinobaseButton.heightAnchor ~= 21
        kinobaseButton.widthAnchor ~= 26
        kinobaseButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        kinobaseButton.tag = 4

        let backgroundImage = UIImageView(image: Asset.Cinema.MainTab.tabBackground.image)
        backgroundImage.contentMode = .scaleToFill
        backgroundImage.layer.masksToBounds = true
        addSubview(backgroundImage.prepareForAutoLayout())
        backgroundImage.topAnchor ~= topAnchor - 50
        backgroundImage.bottomAnchor ~= bottomAnchor + 50
        backgroundImage.leadingAnchor ~= leadingAnchor
        backgroundImage.trailingAnchor ~= trailingAnchor

        let stackView = createStackView(.horizontal, .center, .equalCentering, 0,
                                        with: [ticketsButton, rewardsButton, profileButton, chatButton, kinobaseButton])

        addSubview(stackView.prepareForAutoLayout())
        stackView.pin(to: self, top: 0, left: 30, right: 30, bottom: 0)
    }

    func tapButton(button: UIButton) {
        if !button.isSelected {
            button.isSelected = true
            for but in buttons where button.tag != but.tag {
                but.isSelected = false
            }
            switch button.tag {
            case 0:
                delegate?.ticketsTapped()
            case 1:
                delegate?.rewardsTapped()
            case 2:
                delegate?.profileTapped()
            case 3:
                delegate?.chatTapped()
            case 4:
                delegate?.kinobaseTapped()
            default:
                return
            }
        }
    }

    func reloadData() {
        for but in buttons {
            but.isSelected = false
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
