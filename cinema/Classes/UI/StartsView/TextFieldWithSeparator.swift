//
//  TextFieldWithSeparator.swift
//  cinema
//
//  Created by User on 06.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

class TextFieldWithSeparator: UIView {

    let textField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.cnmFuturaLight(size: 14)
        return textField
    }()

    private let separatorView = UIView()

    override init(frame: CGRect) {

        super.init(frame: frame)

        addSubview(textField.prepareForAutoLayout())

        textField.centerXAnchor ~= centerXAnchor
        textField.topAnchor ~= topAnchor
        textField.widthAnchor ~= 284
        textField.textAlignment = .center

        addSubview(separatorView.prepareForAutoLayout())
        separatorView.centerXAnchor ~= centerXAnchor
        separatorView.topAnchor ~= textField.bottomAnchor + 9
        separatorView.widthAnchor ~= 284
        separatorView.heightAnchor ~= 1
        separatorView.bottomAnchor ~= bottomAnchor

        separatorView.backgroundColor = UIColor.cnmSeparatorColor

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
