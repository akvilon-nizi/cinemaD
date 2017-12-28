//
//  MainTabView.swift
//  cinema
//
//  Created by User on 08.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit
import Kingfisher

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
        ticketsButton.heightAnchor ~= 40
        ticketsButton.widthAnchor ~= 40
        ticketsButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)

        rewardsButton.setImage(Asset.Cinema.MainTab.Passive.reward.image, for: .normal)
        rewardsButton.setImage(Asset.Cinema.MainTab.Active.rewardA.image, for: .selected)
        rewardsButton.heightAnchor ~= 40
        rewardsButton.widthAnchor ~= 40
        rewardsButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        rewardsButton.tag = 1

        profileButton.heightAnchor ~= 60
        profileButton.backgroundColor = UIColor.cnmGreyLight
        profileButton.widthAnchor ~= 60
        profileButton.setImage(Asset.Cinema.Profile.userPlaceholder.image, for: .normal)
        profileButton.layer.cornerRadius = 30
        profileButton.layer.masksToBounds = true
        profileButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        profileButton.tag = 2

        chatButton.setImage(Asset.Cinema.MainTab.Passive.chat.image, for: .normal)
        chatButton.setImage(Asset.Cinema.MainTab.Active.chatA.image, for: .selected)
        chatButton.heightAnchor ~= 40
        chatButton.widthAnchor ~= 40
        chatButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        chatButton.tag = 3

        kinobaseButton.setImage(Asset.Cinema.MainTab.Passive.kinobase.image, for: .normal)
        kinobaseButton.setImage(Asset.Cinema.MainTab.Active.kinobaseA.image, for: .selected)
        kinobaseButton.heightAnchor ~= 40
        kinobaseButton.widthAnchor ~= 40
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
        if UIWindow(frame: UIScreen.main.bounds).bounds.width == 320 {
            stackView.pin(to: self, top: 0, left: 15, right: 15, bottom: 0)
        } else {
            stackView.pin(to: self, top: 0, left: 30, right: 30, bottom: 0)
        }

    }

    func tapButton(button: UIButton) {
//        if !button.isSelected {
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
//        }
    }

    func reloadData() {
        for but in buttons {
            but.isSelected = false
        }
    }

    func setImage(imageUrl: String) {
        if let link = URL(string: imageUrl) {
            KingfisherManager.shared.retrieveImage(with: link, options: nil, progressBlock: nil, completionHandler: {[unowned self] image, _, _, _ in
                if let loadImage = image {
                    self.profileButton.setImage(loadImage, for: .normal)
                } else {
                }
            })
        }
    }

    func tapKinobase() {
        for but in buttons {
            if but.tag != 1 {

            } else {
                but.isSelected = true
            }
        }
        delegate?.rewardsTapped()
    }

    func tapAwards() {
        for but in buttons {
            if but.tag != 4 {

            } else {
                but.isSelected = true
            }
        }
        delegate?.kinobaseTapped()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
