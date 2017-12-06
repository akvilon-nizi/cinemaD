//
//  ActorHeaderView.swift
//  cinema
//
//  Created by iOS on 29.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

class ActorHeaderView: UIView {

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFuturaLight(size: 14)
        label.textColor = UIColor.setColorGray(white: 49)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = L10n.personWasBorn
        return label
    }()

    private let bornLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFutura(size: 16)
        label.textColor = UIColor.setColorGray(white: 58)
        label.text = L10n.personWasBorn
        return label
    }()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFuturaLight(size: 14)
        label.textColor = UIColor.setColorGray(white: 49)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = L10n.personWasBorn
        return label
    }()

    private let userImage: UIImageView = {
        let windowWidth = UIWindow(frame: UIScreen.main.bounds).bounds.width - 160
        let imageView = UIImageView()
            imageView.widthAnchor ~= windowWidth
            imageView.heightAnchor ~= windowWidth / 800 * 1_185
            imageView.layer.cornerRadius = 5.0
            imageView.layer.masksToBounds = true
            imageView.contentMode = .scaleAspectFill
            imageView.backgroundColor = UIColor.lightGray
        return imageView
    }()

    required init(coder _: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init(person: FullPerson) {
        super.init(frame: .zero)

        addSubview(userImage.prepareForAutoLayout())
        userImage.topAnchor ~= topAnchor + 11
        userImage.centerXAnchor ~= centerXAnchor
        if let link = person.imageUrl {
            userImage.kf.setImage(with: URL(string: link))
            userImage.kf.indicatorType = .activity
        }

        addSubview(descriptionLabel.prepareForAutoLayout())
        descriptionLabel.topAnchor ~= userImage.bottomAnchor + 25
        descriptionLabel.trailingAnchor ~= trailingAnchor - 41
        descriptionLabel.leadingAnchor ~= leadingAnchor + 41

        if let description = person.description {
            descriptionLabel.text = description
        }

        addSubview(bornLabel.prepareForAutoLayout())
        bornLabel.topAnchor ~= descriptionLabel.bottomAnchor + 29
        bornLabel.trailingAnchor ~= trailingAnchor - 41
        bornLabel.leadingAnchor ~= leadingAnchor + 41

        addSubview(infoLabel.prepareForAutoLayout())
        infoLabel.topAnchor ~= bornLabel.bottomAnchor + 12
        infoLabel.trailingAnchor ~= trailingAnchor - 41
        infoLabel.leadingAnchor ~= leadingAnchor + 41
        infoLabel.bottomAnchor ~= bottomAnchor

        var infoText = ""
        if let date = person.birthday {
            let now = Date()
            let localized = String.localizedStringWithFormat(String(
                format: NSLocalizedString("%d year(s)", comment: ""),
                locale: Locale(identifier: "RU_ru"),
                Calendar.current.dateComponents([.year], from: date, to: now).year!))
            infoText = date.monthMedium
                + " "
                + date.years
                + L10n.personsYearsText + ", " + localized
        }

        if let place = person.birthPlace, place != "" {
            infoText += ", " + place
        }

        infoLabel.text = infoText
    }
}
