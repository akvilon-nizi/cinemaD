//
// Created by akvilon-nizi on 24/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import MobileCoreServices

class EditingProfileViewController: ParentViewController {

    var output: EditingProfileViewOutput!

    var isEditingAvater: Bool = false

    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.heightAnchor ~= 92
        imageView.widthAnchor ~= 92
        imageView.image = Asset.Cinema.Profile.userPlaceholder.image
        imageView.layer.cornerRadius = 46
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    } ()

    let scrollView = UIScrollView()

    let contentView = UIView()

    let name = EditingView()
    let oldPassword = EditingView()
    let newPassword = EditingView()

    let windowWidth = UIWindow(frame: UIScreen.main.bounds).bounds.size.width

    let nameUser: String
    let avatar: String

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init(nameUser: String, avatar: String) {
        self.nameUser = nameUser
        self.avatar = avatar
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

        let homeButton = UIButton()
        homeButton.setImage(Asset.Cinema.home.image, for: .normal)
        homeButton.addTarget(self, action: #selector(didTapHomeButton), for: .touchUpInside)
        homeButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        frame = homeButton.frame
        frame.origin.x -= 9
        frame.size = CGSize(width: 30, height: 100)
        homeButton.frame = frame
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: homeButton)

        titleViewLabel.text = L10n.editingProfileTitleText
        titleViewLabel.font = UIFont.cnmFutura(size: 20)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        addSubviews()
    }

    private func addSubviews() {

        contentView.addSubview(userImageView.prepareForAutoLayout())
        let width: CGFloat = 34
        userImageView.topAnchor ~= contentView.topAnchor + width
        userImageView.centerXAnchor ~= contentView.centerXAnchor
        userImageView.kf.setImage(with: URL(string: avatar))

        let changePhotoButton = UIButton()
        changePhotoButton.setTitle(L10n.editingProfileChangePhoto, for: .normal)
        changePhotoButton.titleLabel?.font = UIFont.cnmFuturaLight(size: 14)
        changePhotoButton.setTitleColor(UIColor.cnmBlueLight, for: .normal)
        changePhotoButton.addTarget(self, action: #selector(didTapChangePhotoButton), for: .touchUpInside)

        contentView.addSubview(changePhotoButton.prepareForAutoLayout())
        changePhotoButton.topAnchor ~= userImageView.bottomAnchor + 10
        changePhotoButton.centerXAnchor ~= contentView.centerXAnchor

        name.textPlaceholder = L10n.editingProfileChangeName
        if !nameUser.isEmpty {
            name.text = nameUser
        }
        oldPassword.textPlaceholder = L10n.editingProfileOldPassword
        newPassword.textPlaceholder = L10n.editingProfileNewPassword

        let stackView = createStackView(.vertical, .fill, .fill, 0, with: [name])

        contentView.addSubview(stackView.prepareForAutoLayout())
        stackView.topAnchor ~= changePhotoButton.bottomAnchor + 30
        stackView.leadingAnchor ~= contentView.leadingAnchor
        stackView.trailingAnchor ~= contentView.trailingAnchor

        let saveButton = UIButton().setTitleWithColor(title: L10n.editingProfileSaveButton, color: UIColor.cnmMainOrange)
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        contentView.addSubview(saveButton.prepareForAutoLayout())
        saveButton.centerXAnchor ~= contentView.centerXAnchor
        saveButton.topAnchor ~= stackView.bottomAnchor + 28
        //saveButton.bottomAnchor ~= contentView.bottomAnchor - 5

        contentView.layoutSubviews()
        contentView.layoutIfNeeded()
        contentView.frame = CGRect(x: 0, y: 0, width: windowWidth, height: 490)

        view.addSubview(scrollView.prepareForAutoLayout())
        scrollView.pinEdgesToSuperviewEdges()
        scrollView.addSubview(contentView)
        scrollView.showsVerticalScrollIndicator = false

        scrollView.contentSize = contentView.frame.size
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .always
        } else {
            automaticallyAdjustsScrollViewInsets = true
        }

        print()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Actions
    func didTapLeftButton() {
        output?.backButtonTap()
    }

    func didTapHomeButton() {
        output?.homeButtonTap()
    }

    func didTapChangePhotoButton() {
        let alert = UIAlertController(title: title,
                                      message: "Выбрать фотографию",
                                      preferredStyle: UIAlertControllerStyle.alert)

//        let cameraAction = UIAlertAction(title: "Camera",
//                                         style: .default,
//                                         handler: { (_) in
//                                            self.openImagePicker(sourceType: .camera)
//            }
//        )

        let libraryAction = UIAlertAction(title: "Открыть галерею",
                                          style: .default,
                                          handler: { (_) in
                                        self.openImagePicker(sourceType: .photoLibrary)
            }
        )

        alert.addAction(libraryAction)
        //alert.addAction(cameraAction)
        alert.addAction(UIAlertAction(title: L10n.alertButtonCancel, style: .cancel, handler: nil))
        present(alert, animated: true)

    }

    func didTapSaveButton() {

        if name.textTF().isEmpty {
            showAlert(message: "Имя не может быть пустым")
            return
        }

        if newPassword.textTF().isEmpty && !oldPassword.textTF().isEmpty {
            showAlert(message: "Введите новый пароль")
            return
        }

        if !newPassword.textTF().isEmpty && oldPassword.textTF().isEmpty {
            showAlert(message: "Введите старый пароль")
            return
        }

        activityVC.isHidden = false
        activityVC.startAnimating()
        view.bringSubview(toFront: activityVC)

        output?.saveEditing(
            image: isEditingAvater ? userImageView.image : nil,
            name: name.textTF(),
            oldPassword: oldPassword.textTF(),
            password: newPassword.textTF()
        )
    }

    func openImagePicker(sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.mediaTypes = [kUTTypeImage as String]
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }

    func keyboardWillShow(notification: NSNotification) {
        if contentView.frame.origin.y == 0 {
            var frame = contentView.frame
            frame.origin.y = -120
            contentView.frame = frame
        }
    }

    func keyboardWillHide(notification: NSNotification) {
        if contentView.frame.origin.y != 0 {
            var frame = contentView.frame
            frame.origin.y = 0
            contentView.frame = frame
        }
    }
}

// MARK: - EditingProfileViewInput

extension EditingProfileViewController: EditingProfileViewInput {

    func setupInitialState() {

    }

    func getError() {
        showAlert(message: L10n.alertCinemaNetworkErrror)
        activityVC.isHidden = true
        activityVC.stopAnimating()
    }
}

// MARK: - UIImagePickerControllerDelegate

extension EditingProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : Any]
        ) {

        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            userImageView.image = pickedImage
            isEditingAvater = true
        }

        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
