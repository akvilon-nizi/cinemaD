//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import InputMask

class PhoneViewController: ParentViewController {

    var output: PhoneViewOutput!

    let contentView = UIView()
    let titleLabel = UILabel()
    let phoneField = TextFieldWithSeparator()
    let nextButton = UIButton(type: .system).setTitleWithColor(title: L10n.phoneNextButtonText, color: UIColor.cnmMainOrange)
    var phone: String = ""
    var uid: String = ""

    var maskedDelegate: MaskedTextFieldDelegate?

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init() {
        maskedDelegate = MaskedTextFieldDelegate(format: "{+7} ([000]) [000] [00] [00]")
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
        phoneField.leadingAnchor ~= contentView.leadingAnchor
        phoneField.trailingAnchor ~= contentView.trailingAnchor
        phoneField.topAnchor ~= titleLabel.bottomAnchor + 32

        if !phone.isEmpty {
            phoneField.textField.text = phone
            phoneField.textField.isUserInteractionEnabled = false
            phoneField.textField.delegate = self
        } else {
            maskedDelegate?.listener = self
            phoneField.textField.delegate = maskedDelegate
            phoneField.textField.text = "+7 ("
            phoneField.textField.keyboardType = .phonePad
        }

        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        contentView.addSubview(nextButton.prepareForAutoLayout())
        nextButton.centerXAnchor ~= contentView.centerXAnchor
        nextButton.topAnchor ~= phoneField.bottomAnchor + 49

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
    }

    // MARK: - Actions
    func didTapLeftButton() {
        output?.backTap()
    }

    func didTapNextButton() {
        if !phone.isEmpty {
            output?.next(phone: phone, uid: uid, phoneCorrect: nil)
        } else {
            if let phoneCorrect = phoneField.textField.text,
                phoneCorrecting(phone: phoneCorrect).characters.count == 12 {
                output?.next(phone: phone, uid: nil, phoneCorrect: phoneCorrecting(phone: phoneCorrect))
            } else {
                showAlert(message: L10n.alertCinemaCorrectErrror)
            }
        }
    }

    private func phoneCorrecting(phone: String) -> String {
        return phone.replacingOccurrences(
            of: "(", with: "",
            options: NSString.CompareOptions.literal,
            range: nil).replacingOccurrences(
                of: ")",
                with: "",
                options: NSString.CompareOptions.literal,
                range: nil).replacingOccurrences(
                    of: " ",
                    with: "",
                    options: NSString.CompareOptions.literal,
                    range: nil)
    }

    func handleTap(sender: UITapGestureRecognizer? = nil) {
        view.endEditing(true)
    }
}

// MARK: - PhoneViewInput

extension PhoneViewController: PhoneViewInput {

    func setupInitialState() {

    }

    func showNetworkError() {
        showAlert(message: L10n.alertCinemaNetworkErrror)
        activityVC.isHidden = true
        activityVC.stopAnimating()
    }
}

// MARK: - UITextFieldDelegate

extension PhoneViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

extension PhoneViewController: MaskedTextFieldDelegateListener {
}
