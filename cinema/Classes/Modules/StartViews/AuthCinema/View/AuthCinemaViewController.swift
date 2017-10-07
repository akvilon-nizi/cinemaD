//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class AuthCinemaViewController: ParentViewController {

    var output: AuthCinemaViewOutput!

    let contentView = UIView()
    let imageView = UIImageView(image: Asset.StartViews.auth.image)
    let phoneField = TextFieldWithSeparator()
    let passwordField = TextFieldWithSeparator()
    let nextButton = UIButton(type: .system).setTitleWithColor(title: L10n.regButtonText, color: UIColor.cnmMainOrange)

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

        titleViewLabel.text = L10n.authTitleText

        addTopView()
        addStackView()
        addBottomView()
    }

    private func addTopView() {
        view.addSubview(contentView.prepareForAutoLayout())
        contentView.leadingAnchor ~= view.leadingAnchor
        contentView.trailingAnchor ~= view.trailingAnchor
        contentView.centerYAnchor ~= view.centerYAnchor
        contentView.heightAnchor ~= 535

        contentView.addSubview(imageView.prepareForAutoLayout())
        imageView.centerXAnchor ~= contentView.centerXAnchor
        imageView.topAnchor ~= contentView.topAnchor + 35
        imageView.heightAnchor ~= 174
        imageView.widthAnchor ~= 236
    }

    private func addStackView() {
        let stackView = createStackView(.vertical, .fill, .fill, 29.0, with: [phoneField, passwordField])
        phoneField.textField.placeholder = L10n.authPhonePlaceholder
        passwordField.textField.placeholder = L10n.authPasswordPlaceholder

        contentView.addSubview(stackView.prepareForAutoLayout())
        stackView.topAnchor ~= imageView.bottomAnchor + 38
        stackView.leadingAnchor ~= contentView.leadingAnchor
        stackView.trailingAnchor ~= contentView.trailingAnchor
        stackView.heightAnchor ~= 98

        contentView.addSubview(nextButton.prepareForAutoLayout())
        nextButton.topAnchor ~= stackView.bottomAnchor + 28
        nextButton.centerXAnchor ~= contentView.centerXAnchor
    }

    private func addBottomView() {
        let infoLabel = UILabel()
        infoLabel.font = UIFont.cnmFuturaLight(size: 13)
        infoLabel.textColor = UIColor.cnmGreyLight
        infoLabel.text = L10n.authRememberText

        contentView.addSubview(infoLabel.prepareForAutoLayout())
        infoLabel.topAnchor ~= nextButton.bottomAnchor + 19
        infoLabel.centerXAnchor ~= contentView.centerXAnchor

        let conditions = UIButton(type: .system)
        conditions.setTitle(L10n.authHelpButtonText, for: .normal)
        conditions.setTitleColor(UIColor.cnmBlueLight, for: .normal)
        conditions.titleLabel?.font = UIFont.cnmFuturaLight(size: 13)
        conditions.addTarget(self, action: #selector(didTapHelpAuthButton), for: .touchUpInside)

        contentView.addSubview(conditions.prepareForAutoLayout())
        conditions.topAnchor ~= infoLabel.bottomAnchor - 5
        conditions.centerXAnchor ~= contentView.centerXAnchor
    }

    // MARK: - Actions
    func didTapLeftButton() {
        output?.backTap()
    }

    func didTapHelpAuthButton() {
        output?.helpAuth()
    }
}

// MARK: - AuthCinemaViewInput

extension AuthCinemaViewController: AuthCinemaViewInput {

    func setupInitialState() {

    }
}
