//
// Created by Alexander Maslennikov on 04/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class AuthPhoneViewController: ParentViewController {

    var output: AuthPhoneViewOutput!

    fileprivate let numberView = NumberView(withDigitsCount: 10, separateIn: 3, 7, 10)

    private let imageView = UIImageView(image: Asset.Auth.authImage.image)
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()

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

        setupImage()
        setupTitle()
        setupDescription()
        setupPhone()
    }

    private func setupImage() {

        imageView.contentMode = .scaleAspectFit

        view.addSubview(imageView.prepareForAutoLayout())

        imageView.topAnchor ~= view.topAnchor + 50
        imageView.heightAnchor ~= 100
        imageView.widthAnchor ~= imageView.heightAnchor
        imageView.centerXAnchor ~= view.centerXAnchor
    }

    private func setupTitle() {

        view.addSubview(titleLabel.prepareForAutoLayout())

        titleLabel.text = L10n.authTitle
        titleLabel.font = UIFont.fdlGothamProMedium(size: 20)
        titleLabel.textColor = UIColor.fdlGreyishBrown
        titleLabel.textAlignment = .center
        titleLabel.centerXAnchor ~= view.centerXAnchor
        titleLabel.topAnchor ~= imageView.bottomAnchor + 20
    }

    private func setupDescription() {

        view.addSubview(descriptionLabel.prepareForAutoLayout())

        descriptionLabel.text = L10n.authDescription
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.fdlSystemRegular(size: 15)
        descriptionLabel.textColor = UIColor.fdlWarmGrey
        descriptionLabel.textAlignment = .center
        descriptionLabel.widthAnchor ~= 300
        descriptionLabel.centerXAnchor ~= view.centerXAnchor
        descriptionLabel.topAnchor ~= titleLabel.bottomAnchor + 15
    }

    private func setupPhone() {

        let phoneView = UIView()

        view.addSubview(phoneView.prepareForAutoLayout())

        let codeLabel = UILabel()

        numberView.delegate = self

        codeLabel.text = "+7 "
        codeLabel.font = UIFont.fdlGothamProMedium(size: 20)
        codeLabel.textColor = UIColor.fdlGreyishBrown

        phoneView.addSubview(codeLabel.prepareForAutoLayout())
        codeLabel.pinEdgesToSuperviewEdges(excluding: .right)
        codeLabel.widthAnchor ~= 40

        phoneView.addSubview(numberView.prepareForAutoLayout())
        numberView.pinEdgesToSuperviewEdges(excluding: .left)

        numberView.leadingAnchor ~= codeLabel.trailingAnchor

        phoneView.widthAnchor ~= 260
        phoneView.heightAnchor ~= 34
        phoneView.centerXAnchor ~= view.centerXAnchor
        phoneView.topAnchor ~= descriptionLabel.bottomAnchor + 30

        let retryButton = UIButton()

        retryButton.setTitle(L10n.authResendSms, for: .normal)
        retryButton.setTitleColor(UIColor.fdlSalmonPink, for: .normal)
        retryButton.titleLabel?.font = UIFont.fdlSystemRegular(size: 13)

        view.addSubview(retryButton.prepareForAutoLayout())

        retryButton.widthAnchor ~= 130
        retryButton.heightAnchor ~= 20
        retryButton.topAnchor ~= numberView.bottomAnchor + 15
        retryButton.centerXAnchor ~= view.centerXAnchor

        retryButton.addTarget(self, action: #selector(retry), for: .touchUpInside)
    }

    func retry() {

        if numberView.number.characters.count == 10 {

            output.didEndEditing(phone: "7" + numberView.number)
        }
    }

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)

        numberView.activateCursor()
    }
}

extension AuthPhoneViewController: NumberViewDelegate {

    func didFinishInput(text: String) {

        output.didEndEditing(phone: "7" + text)
    }
}

// MARK: - AuthPhoneViewInput

extension AuthPhoneViewController: AuthPhoneViewInput {

    func setupInitialState() {

    }
}
