//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import InputMask

class RegistrationViewController: ParentViewController {

    var output: RegistrationViewOutput!

    let contentView = UIView()
    let imageView = UIImageView(image: Asset.StartViews.auth.image)
    let nameField = TextFieldWithSeparator()
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

        maskedDelegate?.listener = self

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        let backButton = UIButton()
        backButton.setImage(Asset.NavBar.navBarArrowBack.image, for: .normal)
        backButton.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        backButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        var frame = backButton.frame
        frame.size = CGSize(width: 30, height: 100)
        backButton.frame = frame
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        titleViewLabel.text = L10n.regTitleText

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
        contentView.heightAnchor ~= 535

        contentView.addSubview(imageView.prepareForAutoLayout())
        imageView.centerXAnchor ~= contentView.centerXAnchor
        imageView.topAnchor ~= contentView.topAnchor + 35
        imageView.heightAnchor ~= 174
        imageView.widthAnchor ~= 236
    }

    private func addStackView() {
        let stackView = createStackView(.vertical, .fill, .fill, 29.0, with: [nameField, phoneField, passwordField])
        nameField.textField.placeholder = L10n.regNamePlaceholder
        phoneField.textField.placeholder = L10n.regPhonePlaceholder
        passwordField.textField.placeholder = L10n.regPasswordPlaceholder
        passwordField.textField.isSecureTextEntry = true
        nameField.textField.delegate = self
        phoneField.textField.delegate = maskedDelegate
        phoneField.textField.tag = 1
        phoneField.textField.text = "+7 ("
        phoneField.textField.keyboardType = .phonePad
        passwordField.textField.delegate = self
        passwordField.textField.tag = 2

        contentView.addSubview(stackView.prepareForAutoLayout())
        stackView.topAnchor ~= imageView.bottomAnchor + 38
        stackView.leadingAnchor ~= contentView.leadingAnchor
        stackView.trailingAnchor ~= contentView.trailingAnchor
        stackView.heightAnchor ~= 145

        contentView.addSubview(nextButton.prepareForAutoLayout())
        nextButton.topAnchor ~= stackView.bottomAnchor + 28
        nextButton.centerXAnchor ~= contentView.centerXAnchor
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
    }

    private func addBottomView() {
        let infoLabel = UILabel()
        infoLabel.font = UIFont.cnmFuturaLight(size: 13)
        infoLabel.textColor = UIColor.cnmGreyLight
        infoLabel.text = L10n.regInfoText

        contentView.addSubview(infoLabel.prepareForAutoLayout())
        infoLabel.topAnchor ~= nextButton.bottomAnchor + 19
        infoLabel.centerXAnchor ~= contentView.centerXAnchor

        let conditions = UIButton(type: .system)
        conditions.setTitle(L10n.regConditionsButtonText, for: .normal)
        conditions.setTitleColor(UIColor.cnmBlueLight, for: .normal)
        conditions.titleLabel?.font = UIFont.cnmFuturaLight(size: 13)

        let regulations = UIButton(type: .system)
        regulations.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        regulations.setTitle(L10n.regRegulationsButtonText, for: .normal)
        regulations.setTitleColor(UIColor.cnmBlueLight, for: .normal)
        regulations.titleLabel?.font = UIFont.cnmFuturaLight(size: 13)

        let andLabel = UILabel()
        andLabel.font = UIFont.cnmFuturaLight(size: 13)
        andLabel.textColor = UIColor.cnmGreyLight
        andLabel.text = L10n.regAndText

        let stackView = createStackView(.horizontal, .fill, .fill, 5.0, with: [conditions, andLabel, regulations])
        contentView.addSubview(stackView.prepareForAutoLayout())
        stackView.topAnchor ~= infoLabel.bottomAnchor - 5
        stackView.centerXAnchor ~= contentView.centerXAnchor
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

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Actions
    func didTapLeftButton() {
        output?.backTap()
    }

    // MARK: - Actions
    func didTapNextButton() {
        if let phone = phoneField.textField.text?.replacingOccurrences(
            of: "(", with: "",
            options: NSString.CompareOptions.literal,
            range:nil).replacingOccurrences(
                of: ")",
                with: "",
                options: NSString.CompareOptions.literal,
                range:nil).replacingOccurrences(
                    of: " ",
                    with:"",
                    options: NSString.CompareOptions.literal,
                    range:nil),
            phone.characters.count == 12,
            let password = passwordField.textField.text,
            password.characters.count > 3,
            let name = nameField.textField.text,
            name.characters.count > 3, let phoneIn = phoneField.textField.text {
            output?.nextButtonTap(password: password, name: name, phone: phone, phoneIn: phoneIn)
            view.bringSubview(toFront: activityVC)
            activityVC.isHidden = false
            activityVC.startAnimating()
        } else {
            showAlert(message: L10n.alertCinemaCorrectErrror)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityVC.isHidden = true
        activityVC.stopAnimating()
    }

    func handleTap(sender: UITapGestureRecognizer? = nil) {
        view.endEditing(true)
    }
}

// MARK: - RegistrationViewInput

extension RegistrationViewController: RegistrationViewInput {

    func setupInitialState() {

    }

    func showNetworkError() {
        showAlert(message: L10n.alertCinemaNetworkErrror)
        activityVC.isHidden = true
        activityVC.stopAnimating()
    }
}

// MARK: - UITextFieldDelegate

extension RegistrationViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            phoneField.textField.becomeFirstResponder()
        case 1:
            passwordField.textField.becomeFirstResponder()
        default:
            view.endEditing(true)
        }
        return true
    }
}

extension RegistrationViewController: MaskedTextFieldDelegateListener {
}
