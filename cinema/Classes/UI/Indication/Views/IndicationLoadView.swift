//
// Created by Александр Масленников on 20.08.17.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class IndicationLoadView: UIView {

    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let spinnerView = SpinnerView(frame: .zero)

    required init(coder _: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white

        iconImageView.image = Asset.Indicator.indicationIconLoading.image
        addSubview(iconImageView.prepareForAutoLayout())
        iconImageView.centerYAnchor ~= topAnchor + 110
        iconImageView.centerXAnchor ~= centerXAnchor

        titleLabel.font = .fdlGothamProMedium(size: 20)
        titleLabel.textColor = .fdlGreyishBrown
        titleLabel.textAlignment = .center
        titleLabel.text = L10n.indicationTitleLoading
        addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.topAnchor ~= topAnchor + 276
        titleLabel.leadingAnchor ~= leadingAnchor + 20
        titleLabel.trailingAnchor ~= trailingAnchor - 20

        addSubview(spinnerView.prepareForAutoLayout())
        spinnerView.centerYAnchor ~= topAnchor + 394
        spinnerView.centerXAnchor ~= centerXAnchor

        spinnerView.start()
    }
}
