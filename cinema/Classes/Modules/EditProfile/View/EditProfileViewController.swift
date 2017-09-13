//
// Created by incetro on 26/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import InputMask

class EditProfileViewController: ParentViewController {

    var output: EditProfileViewOutput!

    fileprivate let phoneFormatter: PhoneNumberFormatter = PhoneNumberFormatterImplementation()

    fileprivate lazy var photoImporter: EditProfilePhotoImporter = {

        let importer = EditProfilePhotoImporterImplementation()

        importer.delegate = self

        return importer
    }()

    fileprivate var isCorrect: Bool {

        return nameTextView.isCorrect && phoneTextView.isCorrect && regionTextView.isCorrect && emailTextView.isCorrect
    }

    fileprivate let animator = EditProfileAnimator()

    fileprivate let headerView = ProfileHeaderView()

    fileprivate let saveButton: UIButton = {

        let saveButton = UIButton()

        saveButton.layer.cornerRadius = 5

        let gradient = CAGradientLayer()
        let colorLeft = UIColor.fdlWatermelon.cgColor
        let colorRight = UIColor.fdlPeachyPink.cgColor

        gradient.colors = [colorLeft, colorRight]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.05)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.05)
        gradient.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20, height: 48)
        gradient.cornerRadius = 5

        saveButton.titleLabel?.font = UIFont.fdlGothamProMedium(size: 15)
        saveButton.titleLabel?.textColor = .white
        saveButton.clipsToBounds = true
        saveButton.layer.insertSublayer(gradient, at: 0)
        saveButton.setTitle(L10n.profileSaveButtonTitle, for: .normal)

        return saveButton
    }()

    fileprivate let nameTextView: StandardProfileTextView = {

        let nameTextView = StandardProfileTextView()

        nameTextView.setPlaceholder(L10n.profileNamePlaceholder)
        nameTextView.textField.autocorrectionType = .no
        nameTextView.regex = "([а-яА-Я]{1,}|[a-zA-Z]{1,})?"
        nameTextView.errorText = L10n.profileNameValidationText

        return nameTextView
    }()

    fileprivate let phoneTextView: PhoneProfileTextView = {

        let phoneTextView = PhoneProfileTextView(format: "+7 ([000]) [000] [00] [00]")

        phoneTextView.setPlaceholder(L10n.profilePhonePlaceholder)
        phoneTextView.textField.keyboardType = .numberPad
        phoneTextView.textField.autocorrectionType = .no
        phoneTextView.textField.inputAccessoryView = UIToolbar()
        phoneTextView.regex = "\\+7\\s\\([0-9]{3}\\)\\s[0-9]{3}\\s[0-9]{2}\\s[0-9]{2}"
        phoneTextView.errorText = L10n.profilePhoneValidationText

        return phoneTextView
    }()

    fileprivate let regionTextView: StandardProfileTextView = {

        let regionTextView = StandardProfileTextView()

        regionTextView.setPlaceholder(L10n.profileCityPlaceholder)
        regionTextView.textField.autocorrectionType = .no
        regionTextView.errorText = L10n.profileCityValidationText

        return regionTextView
    }()

    fileprivate let emailTextView: StandardProfileTextView = {

        let emailTextView = StandardProfileTextView()

        emailTextView.setPlaceholder(L10n.profileEmailPlaceholder)
        emailTextView.textField.keyboardType = .emailAddress
        emailTextView.textField.autocorrectionType = .no
        emailTextView.regex = "([A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,})?"
        emailTextView.errorText = L10n.profileEmailValidationText

        return emailTextView
    }()

    fileprivate let stackView: UIStackView = {

        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 15

        return stackView
    }()

    var keyboardConstraint: NSLayoutConstraint?

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

        addTapGestureToHideKeyboard()

        output.viewIsReady()
    }

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: false)

        output.needToUpdateProfile()
    }

    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)

        phoneTextView.delegate = nil

        view.endEditing(true)
    }

    func didTapLeftButton() {

        output.leftButtonTapped()
    }

    func didTapSaveButton() {

        let phone = phoneFormatter.unformat(phone: phoneTextView.text)

        guard phone.characters.count == 11 else {

            return
        }

        output.saveButtonTapped(name: nameTextView.text, phone: phone, email: emailTextView.text)
    }

    func didTapCityButton() {

        output.cityButtonTapped()
    }

    fileprivate func setupBackButton() {

        let templateImage = Asset.NavBar.navBarArrowBack.image.withRenderingMode(.alwaysTemplate)

        let backButton = UIButton()

        backButton.setImage(templateImage, for: .normal)
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)

        headerView.addSubview(backButton.prepareForAutoLayout())

        backButton.leadingAnchor ~= headerView.leadingAnchor + 1
        backButton.topAnchor ~= headerView.topAnchor + 31
        backButton.heightAnchor ~= 44
        backButton.widthAnchor ~= backButton.heightAnchor
        backButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

// MARK: - EditProfileViewInput

extension EditProfileViewController: EditProfileViewInput {

    func setupInitialState(withProfile profile: Profile) {

        view.addSubview(saveButton.prepareForAutoLayout())

        saveButton.leadingAnchor ~= view.leadingAnchor + 10
        saveButton.trailingAnchor ~= view.trailingAnchor - 10
        saveButton.bottomAnchor ~= view.bottomAnchor - 10
        saveButton.heightAnchor ~= 48

        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)

        view.addSubview(stackView.prepareForAutoLayout())

        keyboardConstraint = stackView.bottomAnchor ~= view.bottomAnchor - (view.frame.height - ProfileHeaderView.height - 280)
        stackView.leadingAnchor ~= view.leadingAnchor + 20
        stackView.trailingAnchor ~= view.trailingAnchor - 20
        stackView.heightAnchor ~= 260
        stackView.spacing = 7

        stackView.addArrangedSubview(nameTextView)
        stackView.addArrangedSubview(phoneTextView)
        stackView.addArrangedSubview(regionTextView)
        stackView.addArrangedSubview(emailTextView)

        let rightView = UIImageView(image: Asset.Profile.profileArrow.image)
        rightView.frame = CGRect(x: 0, y: 0, width: 10, height: 20)
        rightView.contentMode = .scaleAspectFit

        regionTextView.addSubview(rightView.prepareForAutoLayout())

        rightView.centerYAnchor ~= regionTextView.textField.centerYAnchor
        rightView.widthAnchor ~= 6
        rightView.heightAnchor ~= 10
        rightView.trailingAnchor ~= regionTextView.textField.trailingAnchor

        let cityButton = UIButton()

        regionTextView.addSubview(cityButton.prepareForAutoLayout())

        cityButton.pinEdgesToSuperviewEdges()

        cityButton.addTarget(self, action: #selector(didTapCityButton), for: .touchUpInside)

        if let constraint = keyboardConstraint {

            animator.setup(withConstraint: constraint, rootView: view)
        }

        view.addSubview(headerView.prepareForAutoLayout())

        headerView.pinToSuperview([.left, .right])
        headerView.bottomAnchor ~= stackView.topAnchor - 20
        headerView.heightAnchor ~= ProfileHeaderView.height
        headerView.delegate = self
        headerView.setupAvatarButton()

        setupBackButton()

        update(profile: profile)
    }

    func update(profile: Profile) {

        headerView.userImageView.kf.setImage(with: URL(string: profile.avatar))

        nameTextView.text = profile.name
        phoneTextView.text = phoneFormatter.format(phone: profile.phone)
        regionTextView.text = profile.city?.name ?? ""
        emailTextView.text = profile.email

        [nameTextView, phoneTextView, regionTextView, emailTextView].forEach {

            $0.delegate = self
            $0.update()
        }
    }
}

// MARK: - ProfileTextViewDelegate

extension EditProfileViewController: ProfileTextViewDelegate {

    func textFieldViewEditing(_ textView: ProfileTextView) {

        saveButton.isEnabled = isCorrect
    }
}

// MARK: - EditProfilePhotoImporterDelegate

extension EditProfileViewController: EditProfilePhotoImporterDelegate {

    private func openSettings(text: String) {

        let alertController = UIAlertController(title: nil, message: text, preferredStyle: .alert)

        let settingsAction = UIAlertAction(title: L10n.profileSettingsTitle, style: .default) { _ in

            guard let identifier = Bundle.main.bundleIdentifier else {

                return
            }

            if let url = URL(string: "App-Prefs:path=\(identifier)") {

                UIApplication.shared.open(url, completionHandler: .none)
            }
        }

        let cancelAction = UIAlertAction(title: L10n.profileCancelTitle, style: .cancel) { _ in }

        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true)
    }

    func cameraAccessDenied() {

        openSettings(text: L10n.profileCameraAccessDenied)
    }

    func galleryAccessDenied() {

        openSettings(text: L10n.profileGalleryAccessDenied)
    }

    func didGetImage(image: UIImage) {

        output.imageWasChosen(image: image)
    }
}

// MARK: - ProfileHeaderViewDelegate

extension EditProfileViewController: ProfileHeaderViewDelegate {

    func didTapOnAvatar() {

        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let galleryAction = UIAlertAction(title: L10n.profileGalleryTitle, style: .default) { _ in

            self.photoImporter.openGallery()
        }

        let cameraAction = UIAlertAction(title: L10n.profileCameraTitle, style: .default) { _ in

            self.photoImporter.openCamera()
        }

        let cancelAction = UIAlertAction(title: L10n.profileCancelTitle, style: .cancel) { _ in }

        let removeAction = UIAlertAction(title: L10n.profileRemoveTitle, style: .destructive) { _ in

            self.output.removeAvatarButtonTapped()
        }

        alertController.addAction(removeAction)
        alertController.addAction(cameraAction)
        alertController.addAction(galleryAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true)
    }
}
