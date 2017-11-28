//
// Created by akvilon-nizi on 23/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class SettingsViewController: ParentViewController {

    var output: SettingsViewOutput!

    let saveButton = UIButton()

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()

        view.backgroundColor = .white

        let backButton = UIButton()
        backButton.setImage(Asset.NavBar.navBarArrowBack.image, for: .normal)
        backButton.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        backButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        var frame = backButton.frame
        frame.size = CGSize(width: 30, height: 100)
        backButton.frame = frame
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        saveButton.setImage(Asset.Kinobase.checkMini.image, for: .normal)
//        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        saveButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        frame = saveButton.frame
        frame.size = CGSize(width: 30, height: 100)
        frame.origin.x -= 9
        saveButton.frame = frame
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)

        titleViewLabel.text = L10n.settingsTitleText
        titleViewLabel.font = UIFont.cnmFutura(size: 20)

        let location = SettingsView()
        location.text = L10n.settingsLocationPlace
        location.didSelect = false

        let nightTheme = SettingsView()
        nightTheme.text = L10n.settingsNightTheme
        nightTheme.didSelect = false
        nightTheme.tag = 1

        let pushMessage = SettingsView()
        pushMessage.text = L10n.settingsPushMessage
        pushMessage.didSelect = false
        pushMessage.tag = 2

        let rateApp = SettingsView()
        rateApp.text = L10n.settingsRateApp
        rateApp.tag = 3

        let tellFriends = SettingsView()
        tellFriends.text = L10n.settingsTellFriends
        tellFriends.tag = 4

        let stackView = createStackView(.vertical, .fill, .fill, 0, with: [location, nightTheme, pushMessage, rateApp, tellFriends])

        view.addSubview(stackView.prepareForAutoLayout())
        stackView.topAnchor ~= view.topAnchor + 88
        stackView.leadingAnchor ~= view.leadingAnchor
        stackView.trailingAnchor ~= view.trailingAnchor

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        location.addGestureRecognizer(tap)
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        nightTheme.addGestureRecognizer(tap2)
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        pushMessage.addGestureRecognizer(tap3)
    }

    // MARK: - Actions
    func didTapLeftButton() {
        output?.backButtonTap()
    }

    func handleTap(sender: UITapGestureRecognizer) {
        if let view = sender.view as? SettingsView {
            view.didSelect = !view.didSelect
        }
    }
}

// MARK: - SettingsViewInput

extension SettingsViewController: SettingsViewInput {

    func setupInitialState() {

    }
}
