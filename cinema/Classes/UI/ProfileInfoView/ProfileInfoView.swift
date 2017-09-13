//
//  ProfileInfoView.swift
//  foodle
//
//  Created by incetro on 26/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - ProfileInfoView

class ProfileInfoView: UIView {

    static let height: CGFloat = 190

    weak var delegate: ProfileInfoViewDelegate?

    private let phoneFormatter: PhoneNumberFormatter = PhoneNumberFormatterImplementation()

    private let backgroundView: ShadowView = {

        let backgroundView = ShadowView()

        backgroundView.backgroundColor = .white

        return backgroundView
    }()

    private let titleLabel: UILabel = {

        let titleLabel = UILabel()

        titleLabel.text = "Личные данные"
        titleLabel.font = UIFont.fdlGothamProMedium(size: 20)
        titleLabel.textColor = UIColor.fdlGreyishBrown

        return titleLabel
    }()

    private let nameLabel: UILabel = {

        let nameLabel = UILabel()

        nameLabel.font = UIFont.fdlSystemRegular(size: 15)
        nameLabel.textColor = UIColor.fdlGreyishBrown

        return nameLabel
    }()

    private let phoneLabel: UILabel = {

        let phoneLabel = UILabel()

        phoneLabel.font = UIFont.fdlSystemRegular(size: 15)
        phoneLabel.textColor = UIColor.fdlGreyishBrown

        return phoneLabel
    }()

    private let cityLabel: UILabel = {

        let cityLabel = UILabel()

        cityLabel.font = UIFont.fdlSystemRegular(size: 15)
        cityLabel.textColor = UIColor.fdlGreyishBrown

        return cityLabel
    }()

    private let emailLabel: UILabel = {

        let emailLabel = UILabel()

        emailLabel.font = UIFont.fdlSystemRegular(size: 15)
        emailLabel.textColor = UIColor.fdlGreyishBrown

        return emailLabel
    }()

    fileprivate let editButton: UIButton = {

        let editButton = UIButton()

        editButton.setImage(Asset.Profile.profileEdit.image, for: .normal)

        return editButton
    }()

    override init(frame: CGRect) {

        super.init(frame: frame)

        setupBackgroundView()
        setupEditButton()
        setupTitleLabel()
        setupLeftStack()
        setupRightStack()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setData(_ profile: Profile) {

        if profile.name.isEmpty {

            nameLabel.text = L10n.profileInfoPrePlaceholder + " " + L10n.profileInfoNamePlaceholder.lowercased()
            nameLabel.textColor = UIColor.fdlWarmGrey

        } else {

            nameLabel.textColor = UIColor.fdlGreyishBrown
            nameLabel.text = profile.name
        }

        if profile.phone.isEmpty {

            phoneLabel.text = L10n.profileInfoPrePlaceholder + " " + L10n.profileInfoPhonePlaceholder.lowercased()
            phoneLabel.textColor = UIColor.fdlWarmGrey

        } else {

            phoneLabel.textColor = UIColor.fdlGreyishBrown
            phoneLabel.text = phoneFormatter.format(phone: profile.phone)
        }

        if profile.city == nil {

            cityLabel.text = L10n.profileInfoPrePlaceholder + " " + L10n.profileInfoCityPlaceholder.lowercased()
            cityLabel.textColor = UIColor.fdlWarmGrey

        } else {

            cityLabel.textColor = UIColor.fdlGreyishBrown
            cityLabel.text = profile.city?.name
        }

        if profile.email.isEmpty {

            emailLabel.text = L10n.profileInfoPrePlaceholder + " " + L10n.profileInfoEmailPlaceholder.lowercased()
            emailLabel.textColor = UIColor.fdlWarmGrey

        } else {

            emailLabel.textColor = UIColor.fdlGreyishBrown
            emailLabel.text = profile.email
        }
    }

    func didTapEditButton() {

        delegate?.didTapEditButton()
    }

    private func setupEditButton() {

        addSubview(editButton.prepareForAutoLayout())

        editButton.trailingAnchor ~= trailingAnchor - 15
        editButton.bottomAnchor ~= backgroundView.topAnchor
        editButton.widthAnchor ~= 44
        editButton.heightAnchor ~= 44
        editButton.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)

        editButton.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
    }

    private func setupRightStack() {

        let stackView = UIStackView(arrangedSubviews: [nameLabel, phoneLabel, cityLabel, emailLabel])

        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fillEqually

        backgroundView.addSubview(stackView.prepareForAutoLayout())

        stackView.leadingAnchor ~= backgroundView.leadingAnchor + 115
        stackView.topAnchor ~= backgroundView.topAnchor + 15
        stackView.bottomAnchor ~= backgroundView.bottomAnchor - 15
        stackView.trailingAnchor ~= backgroundView.trailingAnchor - 15
    }

    private func setupLeftStack() {

        let stackView = UIStackView()

        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fillEqually

        [L10n.profileInfoNamePlaceholder, L10n.profileInfoPhonePlaceholder,
         L10n.profileInfoCityPlaceholder, L10n.profileInfoEmailPlaceholder].forEach {

            let label = UILabel()

            label.text = $0
            label.font = UIFont.fdlSystemRegular(size: 13)
            label.textColor = UIColor.fdlWarmGrey

            stackView.addArrangedSubview(label)
        }

        backgroundView.addSubview(stackView.prepareForAutoLayout())

        stackView.leadingAnchor ~= backgroundView.leadingAnchor + 15
        stackView.topAnchor ~= backgroundView.topAnchor + 15
        stackView.bottomAnchor ~= backgroundView.bottomAnchor - 15
        stackView.widthAnchor ~= 100
    }

    private func setupTitleLabel() {

        addSubview(titleLabel.prepareForAutoLayout())

        titleLabel.centerYAnchor ~= editButton.centerYAnchor
        titleLabel.leadingAnchor ~= leadingAnchor + 24
        titleLabel.heightAnchor ~= 20
    }

    private func setupBackgroundView() {

        addSubview(backgroundView.prepareForAutoLayout())

        backgroundView.heightAnchor ~= 139//titleLabel.bottomAnchor + 11
        backgroundView.leadingAnchor ~= leadingAnchor + 10
        backgroundView.trailingAnchor ~= trailingAnchor - 10
        backgroundView.bottomAnchor ~= bottomAnchor - 10
    }
}
