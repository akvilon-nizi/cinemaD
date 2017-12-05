//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import InputMask

class AuthCinemaViewController: ParentViewController {

    var output: AuthCinemaViewOutput!

    let contentView = UIView()
    let imageView = UIImageView(image: Asset.StartViews.auth.image)
    let phoneField = TextFieldWithSeparator()
    let passwordField = TextFieldWithSeparator()
    let nextButton = UIButton(type: .system).setTitleWithColor(title: L10n.regButtonText, color: UIColor.cnmMainOrange)

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
        backButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        var frame = backButton.frame
        frame.size = CGSize(width: 30, height: 100)
        backButton.frame = frame
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        titleViewLabel.text = L10n.authTitleText

        addTopView()
        addStackView()
        addBottomView()

        maskedDelegate?.listener = self

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
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
        phoneField.textField.delegate = maskedDelegate
        phoneField.textField.text = "+7"
        phoneField.textField.keyboardType = .phonePad
//        phoneField.sizeToFit()
        passwordField.textField.placeholder = L10n.authPasswordPlaceholder
        passwordField.textField.delegate = self
        passwordField.textField.isSecureTextEntry = true
        passwordField.textField.tag = 1

        contentView.addSubview(stackView.prepareForAutoLayout())
        stackView.topAnchor ~= imageView.bottomAnchor + 38
        stackView.leadingAnchor ~= contentView.leadingAnchor
        stackView.trailingAnchor ~= contentView.trailingAnchor
        stackView.heightAnchor ~= 98

        contentView.addSubview(nextButton.prepareForAutoLayout())
        nextButton.topAnchor ~= stackView.bottomAnchor + 28
        nextButton.centerXAnchor ~= contentView.centerXAnchor
        nextButton.addTarget(self, action: #selector(didTapAuthButton), for: .touchUpInside)
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

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Actions
    func didTapLeftButton() {
        output?.backTap()
    }

    func didTapHelpAuthButton() {
        output?.helpAuth()
    }

    func didTapAuthButton() {
        if let phone = phoneField.textField.text?.replacingOccurrences(
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
                    range: nil),
            phone.characters.count == 12,
            let password = passwordField.textField.text,
            password.characters.count > 3 {
            output?.auth(phone: phone, password: password)
            view.bringSubview(toFront: activityVC)
            activityVC.isHidden = false
            activityVC.startAnimating()
        } else {
            showAlert(message: L10n.alertCinemaCorrectErrror)
        }
    }

    func keyboardWillShow(notification: NSNotification) {

        //        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 100
        }
        //        }

    }

    func keyboardWillHide(notification: NSNotification) {

        //        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y += 100

        }
        //        }
    }

    func handleTap(sender: UITapGestureRecognizer? = nil) {
        view.endEditing(true)
    }

}

// MARK: - AuthCinemaViewInput

extension AuthCinemaViewController: AuthCinemaViewInput {

    func setupInitialState() {

    }

    func showNetworkError() {
        showAlert(message: L10n.alertCinemaNetworkErrror)
        activityVC.isHidden = true
        activityVC.stopAnimating()
    }

}

// MARK: - UITextFieldDelegate

extension AuthCinemaViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            passwordField.textField.becomeFirstResponder()
        default:
            view.endEditing(true)
        }
        return true
    }
}

extension AuthCinemaViewController: MaskedTextFieldDelegateListener {
}
