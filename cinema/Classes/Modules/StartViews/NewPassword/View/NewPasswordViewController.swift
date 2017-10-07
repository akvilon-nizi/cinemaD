//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class NewPasswordViewController: ParentViewController {

    var output: NewPasswordViewOutput!

    let contentView = UIView()
    let confirmField = TextFieldWithSeparator()
    let passwordField = TextFieldWithSeparator()
    let nextButton = UIButton(type: .system).setTitleWithColor(title: L10n.newPasswordReadyButtonText, color: UIColor.cnmMainOrange)

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()

        let backButton = UIButton()
        backButton.setImage(Asset.NavBar.navBarArrowBack.image, for: .normal)
        backButton.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        backButton.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        titleViewLabel.text = L10n.newPasswordTitleText

        view.addSubview(contentView.prepareForAutoLayout())
        contentView.leadingAnchor ~= view.leadingAnchor
        contentView.trailingAnchor ~= view.trailingAnchor
        contentView.centerYAnchor ~= view.centerYAnchor
        contentView.heightAnchor ~= 235

        passwordField.textField.placeholder = L10n.newPasswordPasswordPlaceholder
        contentView.addSubview(passwordField.prepareForAutoLayout())
        passwordField.topAnchor ~= contentView.topAnchor
        passwordField.centerXAnchor ~= contentView.centerXAnchor

        confirmField.textField.placeholder = L10n.newPasswordConfirmPlaceholder
        contentView.addSubview(confirmField.prepareForAutoLayout())
        confirmField.topAnchor ~= passwordField.bottomAnchor + 27
        confirmField.centerXAnchor ~= contentView.centerXAnchor

        contentView.addSubview(nextButton.prepareForAutoLayout())
        nextButton.centerXAnchor ~= contentView.centerXAnchor
        nextButton.topAnchor ~= confirmField.bottomAnchor + 38
    }
    // MARK: - Actions
    func didTapLeftButton() {
//        output?.backTap()
    }
//
//    func didTapHelpAuthButton() {
//        output?.helpAuth()
//    }
}

// MARK: - NewPasswordViewInput

extension NewPasswordViewController: NewPasswordViewInput {

    func setupInitialState() {

    }
}
