//
// Created by Александр Масленников on 20.08.17.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class IndicationErrorView: UIView {

    weak var output: IndicationErrorOutput?

    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    fileprivate let subtitleLabel = UILabel()
    private let reloadButton = GradientButton()

    required init(coder _: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white

        iconImageView.image = Asset.Indicator.indicationIconError.image
        addSubview(iconImageView.prepareForAutoLayout())
        iconImageView.centerYAnchor ~= topAnchor + 110
        iconImageView.centerXAnchor ~= centerXAnchor

        titleLabel.font = .fdlGothamProMedium(size: 20)
        titleLabel.textColor = .fdlGreyishBrown
        titleLabel.textAlignment = .center
        titleLabel.text = L10n.indicationTitleError
        addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.topAnchor ~= topAnchor + 276
        titleLabel.leadingAnchor ~= leadingAnchor + 20
        titleLabel.trailingAnchor ~= trailingAnchor - 20

        subtitleLabel.font = .fdlSystemRegular(size: 15)
        subtitleLabel.textColor = .fdlWarmGrey
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 4
        addSubview(subtitleLabel.prepareForAutoLayout())
        subtitleLabel.topAnchor ~= titleLabel.bottomAnchor + 14
        subtitleLabel.leadingAnchor ~= leadingAnchor + 20
        subtitleLabel.trailingAnchor ~= trailingAnchor - 20
        subtitleLabel.heightAnchor ~= 76

        reloadButton.addTarget(self, action: #selector(handleReloadButtonPressed), for: .touchUpInside)
        reloadButton.setTitle(L10n.indicationButtonReload.uppercased(), for: .normal)
        addSubview(reloadButton.prepareForAutoLayout())
        reloadButton.topAnchor ~= subtitleLabel.bottomAnchor + 14
        reloadButton.centerXAnchor ~= centerXAnchor
        reloadButton.widthAnchor ~= 150
        reloadButton.heightAnchor ~= 40
    }

    // MARK: - Actions

    func handleReloadButtonPressed() {
        output?.reloadPressed(in: self)
    }
}

extension IndicationErrorView: IndicationErrorInput {

    func update(message: String) {
        subtitleLabel.text = message
    }
}
