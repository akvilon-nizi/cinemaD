//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class PhoneViewController: ParentViewController {

    var output: PhoneViewOutput!

    let contentView = UIView()
    let titleLabel = UILabel()
    let phoneField = TextFieldWithSeparator()
    let nextButton = UIButton(type: .system).setTitleWithColor(title: L10n.phoneNextButtonText, color: UIColor.cnmMainOrange)

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

        titleViewLabel.text = L10n.phoneTitleText

        view.addSubview(contentView.prepareForAutoLayout())
        contentView.leadingAnchor ~= view.leadingAnchor
        contentView.trailingAnchor ~= view.trailingAnchor
        contentView.centerYAnchor ~= view.centerYAnchor
        contentView.heightAnchor ~= 235

        titleLabel.text = L10n.phoneInfoText
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.cnmGreyTextColor
        titleLabel.font = UIFont.cnmFuturaLight(size: 16)
        contentView.addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.centerXAnchor ~= contentView.centerXAnchor
        titleLabel.topAnchor ~= contentView.topAnchor

        phoneField.textField.placeholder = L10n.phonePhonePlaceholder
        contentView.addSubview(phoneField.prepareForAutoLayout())
        phoneField.centerXAnchor ~= contentView.centerXAnchor
        phoneField.topAnchor ~= titleLabel.bottomAnchor + 32

        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        contentView.addSubview(nextButton.prepareForAutoLayout())
        nextButton.centerXAnchor ~= contentView.centerXAnchor
        nextButton.topAnchor ~= phoneField.bottomAnchor + 49
    }

    // MARK: - Actions
    func didTapLeftButton() {
        output?.backTap()
    }

    func didTapNextButton() {
        output?.next()
    }
}

// MARK: - PhoneViewInput

extension PhoneViewController: PhoneViewInput {

    func setupInitialState() {

    }
}
