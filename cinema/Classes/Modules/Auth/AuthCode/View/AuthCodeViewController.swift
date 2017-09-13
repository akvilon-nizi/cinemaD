//
// Created by incetro on 21/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class AuthCodeViewController: ParentViewController {

    var output: AuthCodeViewOutput!

    private var canResendCode = true

    private let retryButton: UIButton = {

        let retryButton = UIButton()

        retryButton.setTitle(L10n.authResendSms, for: .normal)
        retryButton.setTitleColor(UIColor.fdlSalmonPink, for: .normal)
        retryButton.titleLabel?.font = UIFont.fdlSystemRegular(size: 13)

        return retryButton
    }()

    private let changeNumberButton: UIButton = {

        let changeNumberButton = UIButton()

        changeNumberButton.setTitle(L10n.authChangeNumber, for: .normal)
        changeNumberButton.setTitleColor(UIColor.fdlSalmonPink, for: .normal)
        changeNumberButton.titleLabel?.font = UIFont.fdlSystemRegular(size: 13)

        return changeNumberButton
    }()

    private let clockImageView: UIImageView = {

        let clockImageView = UIImageView(image: Asset.Auth.authClock.image)

        clockImageView.contentMode = .scaleAspectFit
        clockImageView.isHidden = true

        return clockImageView
    }()

    fileprivate let backButton: UIButton = {

        let backButton = UIButton()

        backButton.setImage(Asset.Auth.authClose.image, for: .normal)

        return backButton
    }()

    fileprivate let imageView = UIImageView(image: Asset.Auth.authConfirmationImage.image)

    fileprivate let descriptionLabel: UILabel = {

        let descriptionLabel = UILabel()

        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.fdlSystemRegular(size: 15)
        descriptionLabel.textColor = UIColor.fdlWarmGrey
        descriptionLabel.textAlignment = .center

        return descriptionLabel
    }()

    fileprivate let titleLabel: UILabel = {

        let titleLabel = UILabel()

        titleLabel.text = L10n.authConfirmNumber
        titleLabel.font = UIFont.fdlGothamProMedium(size: 20)
        titleLabel.textColor = UIColor.fdlGreyishBrown

        return titleLabel
    }()

    private var second = 30

    weak var timer: Timer?

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
    }

    func tick() {

        second -= 1

        if second > 0 {

            let localized = String.localizedStringWithFormat(String(
                format: NSLocalizedString("%d second(s)", comment: ""),
                locale: Locale(identifier: "RU_ru"),
                second))

            changeNumberButton.setTitle(L10n.authWaitTitle(localized), for: .normal)

        } else {

            clockImageView.isHidden = true
            changeNumberButton.setTitle(L10n.authChangeNumber, for: .normal)
            changeNumberButton.isUserInteractionEnabled = true
            retryButton.isUserInteractionEnabled = true
            canResendCode = true
            timer?.invalidate()
            second = 30
        }
    }

    func setupButtons(topView: UIView) {

        view.addSubview(retryButton.prepareForAutoLayout())

        retryButton.widthAnchor ~= 130
        retryButton.heightAnchor ~= 20
        retryButton.topAnchor ~= topView.bottomAnchor + 25
        retryButton.trailingAnchor ~= view.centerXAnchor - 15

        retryButton.addTarget(self, action: #selector(retry), for: .touchUpInside)

        view.addSubview(changeNumberButton.prepareForAutoLayout())

        changeNumberButton.widthAnchor ~= 130
        changeNumberButton.heightAnchor ~= 20
        changeNumberButton.topAnchor ~= topView.bottomAnchor + 25
        changeNumberButton.leadingAnchor ~= view.centerXAnchor + 15

        view.addSubview(clockImageView.prepareForAutoLayout())
        clockImageView.centerXAnchor ~= view.centerXAnchor
        clockImageView.topAnchor ~= topView.bottomAnchor + 25

        changeNumberButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
    }

    func startTimer() {

        retryButton.isUserInteractionEnabled = false
        changeNumberButton.isUserInteractionEnabled = false
        clockImageView.isHidden = false
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }

    func retry() {

        if canResendCode {

            output.retryButtonTapped()

            startTimer()
        }
    }

    func didTapCloseButton() {

        output.closeButtonTapped()
    }
}

// MARK: - NumberViewDelegate

extension AuthCodeViewController: NumberViewDelegate {

    func didFinishInput(text: String) {

        output.didEndEditing(code: text)
    }
}

// MARK: - AuthCodeViewInput

extension AuthCodeViewController: AuthCodeViewInput {

    func setupInitialState(withPhone phone: String) {

        if navigationController != nil {

            backButton.setImage(Asset.Auth.authClose.image, for: .normal)
            backButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
            backButton.sizeToFit()
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        } else {

            view.addSubview(backButton.prepareForAutoLayout())

            backButton.leadingAnchor ~= view.leadingAnchor + 11
            backButton.topAnchor ~= view.topAnchor + 31

            backButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        }

        imageView.contentMode = .scaleAspectFit

        view.addSubview(imageView.prepareForAutoLayout())

        imageView.topAnchor ~= view.topAnchor + 50
        imageView.heightAnchor ~= 100
        imageView.widthAnchor ~= imageView.heightAnchor
        imageView.centerXAnchor ~= view.centerXAnchor

        view.addSubview(titleLabel.prepareForAutoLayout())

        titleLabel.textAlignment = .center
        titleLabel.centerXAnchor ~= view.centerXAnchor
        titleLabel.topAnchor ~= imageView.bottomAnchor + 30

        view.addSubview(descriptionLabel.prepareForAutoLayout())

        var phone = phone

        phone.insert(" ", at: phone.index(phone.startIndex, offsetBy: 9))
        phone.insert(" ", at: phone.index(phone.startIndex, offsetBy: 7))
        phone.insert(" ", at: phone.index(phone.startIndex, offsetBy: 4))
        phone.insert(" ", at: phone.index(phone.startIndex, offsetBy: 1))
        phone.insert("+", at: phone.index(phone.startIndex, offsetBy: 0))

        descriptionLabel.text = L10n.authCodeSend(phone)
        descriptionLabel.widthAnchor ~= 300
        descriptionLabel.centerXAnchor ~= view.centerXAnchor
        descriptionLabel.topAnchor ~= titleLabel.bottomAnchor + 15

        let numberView = NumberView(withDigitsCount: 5)

        view.addSubview(numberView.prepareForAutoLayout())

        numberView.delegate = self

        numberView.topAnchor ~= descriptionLabel.bottomAnchor + 20
        numberView.widthAnchor ~= 160
        numberView.centerXAnchor ~= view.centerXAnchor

        setupButtons(topView: numberView)

        numberView.activateCursor()

        startTimer()
    }
}
