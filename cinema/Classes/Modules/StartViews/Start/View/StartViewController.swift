//
// Created by akvilon-nizi on 04/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class StartViewController: ParentViewController {

    var output: StartViewOutput!

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFuturaMedium(size: 17)
        label.textColor = UIColor.cnmGreyColor
        label.text = L10n.startTitleText
        return label
    }()

    let logoImageView = UIImageView(image: Asset.StartViews.Start.shape.image)
    let contentView = UIView()

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()

        let imageView = UIImageView(image: Asset.StartViews.Start.background.image)
        view.addSubview(imageView.prepareForAutoLayout())
        imageView.pinEdgesToSuperviewEdges()

        view.addSubview(contentView.prepareForAutoLayout())
        contentView.leadingAnchor ~= view.leadingAnchor
        contentView.trailingAnchor ~= view.trailingAnchor
        contentView.centerYAnchor ~= view.centerYAnchor
        contentView.heightAnchor ~= 435

        addTopViews()
        addBottomViews()
    }

    private func addTopViews() {
        contentView.addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.topAnchor ~= contentView.topAnchor
        titleLabel.centerXAnchor ~= contentView.centerXAnchor

        contentView.addSubview(logoImageView.prepareForAutoLayout())
        logoImageView.topAnchor ~= titleLabel.bottomAnchor + 26
        logoImageView.centerXAnchor ~= contentView.centerXAnchor
        logoImageView.heightAnchor ~= 121
        logoImageView.widthAnchor ~= 158

        let formImageView = UIImageView(image: Asset.StartViews.Start.forma.image)
        logoImageView.addSubview(formImageView.prepareForAutoLayout())
        formImageView.centerXAnchor ~= logoImageView.centerXAnchor
        formImageView.centerYAnchor ~= logoImageView.centerYAnchor - 10
        formImageView.heightAnchor ~= 38
        formImageView.widthAnchor ~= 43
    }

    private func addBottomViews() {
        let fbButton = UIButton(type: .system).setTitleWithColor(title: L10n.startFacebookText, color: UIColor.cnmFbColor)
        let vkButtom = UIButton(type: .system).setTitleWithColor(title: L10n.startVkontakteText, color: UIColor.cnmVkColor)
        let regButton = UIButton(type: .system).setTitleWithColor(title: L10n.startRegistrationText, color: UIColor.cnmMainOrange)
        regButton.addTarget(self, action: #selector(handleTapRegButton), for: .touchUpInside)
        let buttonsStackView = createStackView(.vertical, .fill, .fill, 11.0, with: [fbButton, vkButtom, regButton])
        contentView.addSubview(buttonsStackView.prepareForAutoLayout())
        buttonsStackView.centerXAnchor ~= contentView.centerXAnchor
        buttonsStackView.topAnchor ~= logoImageView.bottomAnchor + 63

        let authLabel = UILabel()
        authLabel.textColor = .cnmGreyTextColor
        authLabel.font = UIFont.cnmFutura(size: 12)
        authLabel.text = L10n.startHaveAuthText

        let authButton = UIButton(type: .system)
        authButton.addTarget(self, action: #selector(handleTapAuthButton), for: .touchUpInside)
        authButton.setTitle(L10n.startButtonAuthText, for: .normal)
        authButton.titleLabel?.font = UIFont.cnmFutura(size: 12)
        authButton.setTitleColor(UIColor.cnmBlueLight, for: .normal)

        let bottomStackView = createStackView(.horizontal, .fill, .fill, 5.0, with: [authLabel, authButton])
        contentView.addSubview(bottomStackView.prepareForAutoLayout())
        bottomStackView.centerXAnchor ~= contentView.centerXAnchor
        bottomStackView.topAnchor ~= buttonsStackView.bottomAnchor + 21
        bottomStackView.bottomAnchor ~= contentView.bottomAnchor
    }

    // MARK: - Actions
    @objc func handleTapRegButton() {
        output?.registration()
    }

    @objc func handleTapAuthButton() {
        output?.auth()
    }
}

// MARK: - StartViewInput

extension StartViewController: StartViewInput {

    func setupInitialState() {

    }
}
