//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class HelpAuthViewController: ParentViewController {

    var output: HelpAuthViewOutput!

    // MARK: - Life cycle

    let contentView = UIView()
    let imageView = UIImageView(image: Asset.StartViews.auth.image)
    let smsButton = UIButton(type: .system).setTitleWithColor(title: L10n.authHelpSmsButtonText, color: UIColor.cnmMainOrange)
    let postButton = UIButton(type: .system).setTitleWithColor(title: L10n.authHelpPostButtonText, color: UIColor.cnmMainOrange)

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
        backButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        var frame = backButton.frame
        frame.size = CGSize(width: 30, height: 100)
        backButton.frame = frame
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        titleViewLabel.text = L10n.authHelpTitleText

        view.addSubview(contentView.prepareForAutoLayout())
        contentView.leadingAnchor ~= view.leadingAnchor
        contentView.trailingAnchor ~= view.trailingAnchor
        contentView.centerYAnchor ~= view.centerYAnchor
        contentView.heightAnchor ~= 185

        addButtonView()
        addBottomView()
    }

    private func addButtonView() {

        contentView.addSubview(smsButton.prepareForAutoLayout())
        smsButton.topAnchor ~= contentView.topAnchor
        smsButton.centerXAnchor ~= contentView.centerXAnchor
        let phoneImage = UIImageView(image: Asset.StartViews.Help.phone.image)
        smsButton.addSubview(phoneImage.prepareForAutoLayout())
        if let titleLabel = smsButton.titleLabel {
            phoneImage.trailingAnchor ~= titleLabel.leadingAnchor - 10
            phoneImage.centerYAnchor ~= smsButton.centerYAnchor
            phoneImage.heightAnchor ~= 21
            phoneImage.widthAnchor ~= 13
        }
        smsButton.addTarget(self, action:  #selector(didTapSMSButton), for: .touchUpInside)

        contentView.addSubview(postButton.prepareForAutoLayout())
        postButton.topAnchor ~= smsButton.bottomAnchor + 23
        postButton.centerXAnchor ~= contentView.centerXAnchor
        let postImage = UIImageView(image: Asset.StartViews.Help.post.image)
        postButton.addSubview(postImage.prepareForAutoLayout())
        if let titleLabel = postButton.titleLabel {
            postImage.trailingAnchor ~= titleLabel.leadingAnchor - 10
            postImage.centerYAnchor ~= postButton.centerYAnchor
            postImage.heightAnchor ~= 17
            postImage.widthAnchor ~= 23
        }
        postButton.addTarget(self, action:  #selector(didTapPostButton), for: .touchUpInside)
    }

    private func addBottomView() {
        let conditions = UIButton(type: .system)
        conditions.setTitle(L10n.authHelpCenterText, for: .normal)
        conditions.setTitleColor(UIColor.cnmBlueLight, for: .normal)
        conditions.titleLabel?.font = UIFont.cnmFuturaLight(size: 13)
        contentView.addSubview(conditions.prepareForAutoLayout())
        conditions.topAnchor ~= postButton.bottomAnchor + 31
        conditions.centerXAnchor ~= contentView.centerXAnchor
    }

    // MARK: - Actions
    @objc func didTapLeftButton() {
        output?.backTap()
    }

    @objc func didTapSMSButton() {
        output?.smsTap()
    }

    @objc func didTapPostButton() {
        output?.postTap()
    }
}

// MARK: - HelpAuthViewInput

extension HelpAuthViewController: HelpAuthViewInput {

    func setupInitialState() {

    }
}
