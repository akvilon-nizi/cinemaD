//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class ConfirmationViewController: ParentViewController {

    var output: ConfirmationViewOutput!

    let contentView = UIView()
    let imageView = UIImageView(image: Asset.StartViews.Confirmation.lock.image)
    let infoLabel = UILabel()
    let codeField = TextFieldWithSeparator()
    let newCodeButton = UIButton(type: .system)
    let nextButton = UIButton(type: .system).setTitleWithColor(title: L10n.confirmationNextButtonText, color: UIColor.cnmMainOrange)
    let phone: String
    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init(_ phone: String) {
        self.phone = phone
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()

        let backButton = UIButton()
        backButton.setImage(Asset.NavBar.navBarArrowBack.image, for: .normal)
        backButton.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        backButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        var frame = backButton.frame
        frame.size = CGSize(width: 30, height: 100)
        backButton.frame = frame
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        titleViewLabel.text = L10n.confirmationTitleText

        addTopView()
        addStackView()
        addBottomView()

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
    }

    private func addTopView() {
        view.addSubview(contentView.prepareForAutoLayout())
        contentView.leadingAnchor ~= view.leadingAnchor
        contentView.trailingAnchor ~= view.trailingAnchor
        contentView.centerYAnchor ~= view.centerYAnchor
        contentView.heightAnchor ~= 435

        contentView.addSubview(imageView.prepareForAutoLayout())
        imageView.centerXAnchor ~= contentView.centerXAnchor
        imageView.topAnchor ~= contentView.topAnchor + 20
        imageView.heightAnchor ~= 54
        imageView.widthAnchor ~= 44
    }

    private func addStackView() {

        infoLabel.text = L10n.confirmationInfoText(phone)
        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = .center
        infoLabel.textColor = UIColor.cnmGreyTextColor
        infoLabel.font = UIFont.cnmFuturaLight(size: 16)
        contentView.addSubview(infoLabel.prepareForAutoLayout())
        infoLabel.centerXAnchor ~= contentView.centerXAnchor
        infoLabel.topAnchor ~= imageView.bottomAnchor + 27

        codeField.textField.placeholder = L10n.confirmationCodeText
        contentView.addSubview(codeField.prepareForAutoLayout())
        codeField.centerXAnchor ~= contentView.centerXAnchor
        codeField.topAnchor ~= infoLabel.bottomAnchor + 32
        codeField.trailingAnchor ~= contentView.trailingAnchor
        codeField.leadingAnchor ~= contentView.leadingAnchor
        codeField.textField.keyboardType = .numberPad
        codeField.textField.delegate = self

        newCodeButton.addTarget(self, action: #selector(handleRepeatButton), for: .touchUpInside)
        newCodeButton.setTitle(L10n.confirmationNewPasswordButton, for: .normal)
        newCodeButton.titleLabel?.font = UIFont.cnmFutura(size: 12)
        newCodeButton.setTitleColor(UIColor.cnmBlueLight, for: .normal)
        contentView.addSubview(newCodeButton.prepareForAutoLayout())
        newCodeButton.centerXAnchor ~= contentView.centerXAnchor
        newCodeButton.topAnchor ~= codeField.bottomAnchor + 8
    }

    private func addBottomView() {

        nextButton.addTarget(self, action: #selector(handleNextButton), for: .touchUpInside)
        contentView.addSubview(nextButton.prepareForAutoLayout())
        nextButton.centerXAnchor ~= contentView.centerXAnchor
        nextButton.topAnchor ~= newCodeButton.bottomAnchor + 26

        let authLabel = UILabel()
        authLabel.textColor = .cnmGreyTextColor
        authLabel.font = UIFont.cnmFutura(size: 12)
        authLabel.text = L10n.confirmationHaveAuthText

        let authButton = UIButton(type: .system)
        authButton.addTarget(self, action: #selector(handleAuthButton), for: .touchUpInside)
        authButton.setTitle(L10n.confirmationButtonAuthText, for: .normal)
        authButton.titleLabel?.font = UIFont.cnmFutura(size: 12)
        authButton.setTitleColor(UIColor.cnmBlueLight, for: .normal)

        let bottomStackView = createStackView(.horizontal, .fill, .fill, 5.0, with: [authLabel, authButton])
        contentView.addSubview(bottomStackView.prepareForAutoLayout())
        bottomStackView.centerXAnchor ~= contentView.centerXAnchor
        bottomStackView.topAnchor ~= nextButton.bottomAnchor + 26
    }

    deinit {
        view.endEditing(true)
    }

    // MARK: - Actions
    func didTapLeftButton() {
        output?.back()
    }

    func handleRepeatButton() {
        output?.repeatCode()
    }

    func handleAuthButton() {
        output?.auth()
    }

    func handleNextButton() {
        if let code = codeField.textField.text, code.characters.count > 5 {
            output?.sendCode(code: code)
        } else {
            showAlert(message: L10n.alertCinemaCorrectErrror)
        }
//        output?.next()
    }

    func handleTap(sender: UITapGestureRecognizer? = nil) {
        view.endEditing(true)
    }
}

// MARK: - ConfirmationViewInput

extension ConfirmationViewController: ConfirmationViewInput {

    func setupInitialState() {
    }

    func showNetworkError() {
        showAlert(message: L10n.alertCinemaNetworkErrror)
//        activityVC.isHidden = true
//        activityVC.stopAnimating()
    }
}

// MARK: - UITextFieldDelegate

extension ConfirmationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 6 // Bool
    }
}
