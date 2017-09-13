//
// Created by incetro on 25/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class ProfileViewController: ParentViewController {

    fileprivate let scrollView: UIScrollView = {

        let scrollView = UIScrollView()

        scrollView.showsVerticalScrollIndicator = false

        return scrollView
    }()

    fileprivate let pushSwitch: UISwitch = {

        let pushSwitch = UISwitch()

        pushSwitch.onTintColor = UIColor.fdlSalmonPink
        pushSwitch.tintColor = UIColor.fdlPaleGrey
        pushSwitch.isOn = true

        return pushSwitch
    }()

    fileprivate let profileInfoView: ProfileInfoView = {

        let profileInfoView = ProfileInfoView()

        profileInfoView.backgroundColor = .clear
        profileInfoView.clipsToBounds = false

        return profileInfoView
    }()

    fileprivate let profileCardsView: ProfileCardsView = {

        let profileCardsView = ProfileCardsView()

        return profileCardsView
    }()

    fileprivate let headerView = ProfileHeaderView()

    fileprivate let exitButton: UIButton = {

        let exitButton = UIButton()

        exitButton.backgroundColor = UIColor.fdlPaleGrey
        exitButton.setTitleColor(UIColor.fdlCoolGrey, for: .normal)
        exitButton.setTitle("Выйти из приложения", for: .normal)
        exitButton.titleLabel?.font = UIFont.fdlSystemRegular(size: 15)

        return exitButton
    }()

    fileprivate var cardsConstraint: NSLayoutConstraint?

    var output: ProfileViewOutput!

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {

        return .lightContent
    }

    override func viewDidLoad() {

        super.viewDidLoad()

        exitButton.addTarget(self, action: #selector(didTapExitButton), for: .touchUpInside)

        automaticallyAdjustsScrollViewInsets = false

        output.viewIsReady()
    }

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: false)

        output.needUpdateProfile()
    }

    func didTapLeftButton() {

        output.leftButtonTapped()
    }

    fileprivate func setupPushSwitch(inScrollView scrollView: UIScrollView, withTopAnchor topAnchor: NSLayoutYAxisAnchor) {

        let pushLabel = UILabel()

        pushLabel.textColor = UIColor.fdlGreyishBrown
        pushLabel.font = UIFont.fdlSystemRegular(size: 15)
        pushLabel.text = L10n.profilePushNotificationsPlaceholder

        scrollView.addSubview(pushLabel.prepareForAutoLayout())

        pushLabel.leadingAnchor ~= scrollView.leadingAnchor + 25
        pushLabel.heightAnchor ~= 15

        scrollView.addSubview(pushSwitch.prepareForAutoLayout())

        pushSwitch.topAnchor ~= topAnchor + 30
        pushSwitch.centerYAnchor ~= pushLabel.centerYAnchor
        pushSwitch.trailingAnchor ~= scrollView.leadingAnchor + (view.frame.width - 25)

        pushLabel.centerYAnchor ~= pushSwitch.centerYAnchor

        pushSwitch.addTarget(self, action: #selector(switchAction(sender:)), for: .valueChanged)
    }

    fileprivate func setupExitButton(inView view: UIView) {

        view.addSubview(exitButton.prepareForAutoLayout())

        exitButton.pinEdgesToSuperviewEdges(excluding: .top)
        exitButton.heightAnchor ~= 50
    }

    fileprivate func setupProfileInfoView(inScrollView scrollView: UIScrollView, withTopAnchor topAnchor: NSLayoutYAxisAnchor) {

        scrollView.addSubview(profileInfoView.prepareForAutoLayout())

        profileInfoView.leadingAnchor ~= scrollView.leadingAnchor
        profileInfoView.topAnchor ~= topAnchor + 30
        profileInfoView.widthAnchor ~= view.frame.width
        profileInfoView.heightAnchor ~= ProfileInfoView.height
    }

    fileprivate func setupProfileCardsView(inScrollView scrollView: UIScrollView, withTopAnchor topAnchor: NSLayoutYAxisAnchor) {

        scrollView.addSubview(profileCardsView.prepareForAutoLayout())

        profileCardsView.topAnchor ~= topAnchor + 30
        profileCardsView.leadingAnchor ~= scrollView.leadingAnchor
        cardsConstraint = profileCardsView.heightAnchor ~= profileCardsView.height
        profileCardsView.widthAnchor ~= view.frame.width
    }

    func didTapExitButton() {

        let alert = UIAlertController(title: nil, message: "Вы уверены?", preferredStyle: .alert)

        let yes = UIAlertAction(title: "Да", style: .destructive) { _ in

            self.output.exitButtonTapped()
        }

        let no = UIAlertAction(title: "Нет", style: .default) { _ in }

        alert.addAction(yes)
        alert.addAction(no)

        present(alert, animated: true)
    }

    func switchAction(sender: UISwitch) {

        output.notificationsWasSwitched(enabled: sender.isOn)
    }

    func recalculateContentSize() {

        let height = 30 +
                     ProfileInfoView.height + 30 +
                     profileCardsView.height + 30 + 25 + 30

        scrollView.contentSize = CGSize(width: view.frame.width, height: height)
    }
}

// MARK: - ProfileCardsViewDelegate

extension ProfileViewController: ProfileCardsViewDelegate {

    func didTapAddCardButton() {

        output.addCardButtonTapped()
    }

    func didSelectCard(_ card: Card) {

        output.cardButtonTapped(card: card)
    }
}

extension ProfileViewController: ProfileInfoViewDelegate {

    func didTapEditButton() {

        output.editButtonTapped()
    }
}

// MARK: - ProfileViewInput

extension ProfileViewController: ProfileViewInput {

    func setupInitialState() {

        view.addSubview(scrollView.prepareForAutoLayout())

        let templateImage = Asset.NavBar.navBarMenu.image.withRenderingMode(.alwaysTemplate)

        let backButton = UIButton()
        backButton.setImage(templateImage, for: .normal)
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)

        view.addSubview(backButton.prepareForAutoLayout())

        backButton.widthAnchor ~= 44
        backButton.heightAnchor ~= 44
        backButton.leadingAnchor ~= view.leadingAnchor + 4
        backButton.topAnchor ~= view.topAnchor + 19
        backButton.imageEdgeInsets = UIEdgeInsets(top: 14, left: 9, bottom: 14, right: 9)

        setupExitButton(inView: view)

        scrollView.pinEdgesToSuperviewEdges(excluding: .bottom)
        scrollView.bottomAnchor ~= exitButton.topAnchor
        scrollView.widthAnchor ~= view.frame.width

        scrollView.parallaxHeader.view = headerView
        scrollView.parallaxHeader.height = ProfileHeaderView.height
        scrollView.parallaxHeader.minimumHeight = 0
        scrollView.parallaxHeader.mode = .fill

        profileCardsView.delegate = self
        profileInfoView.delegate = self

        setupProfileInfoView(inScrollView: scrollView, withTopAnchor: headerView.bottomAnchor)
        setupProfileCardsView(inScrollView: scrollView, withTopAnchor: profileInfoView.bottomAnchor)
        setupPushSwitch(inScrollView: scrollView, withTopAnchor: profileCardsView.bottomAnchor)

        recalculateContentSize()
    }

    func updateProfile(_ profile: Profile) {

        pushSwitch.isOn = profile.pushNotifications

        profileInfoView.setData(profile)

        headerView.userImageView.kf.setImage(with: URL(string: profile.avatar))

        updateCards(profile.cards)
    }

    func updateCards(_ cards: [Card]) {

        profileCardsView.setCards(cards)

        cardsConstraint?.constant = profileCardsView.height

        UIView.animate(withDuration: 0.2) {

            self.view.layoutIfNeeded()
        }

        recalculateContentSize()
    }
}
