//
//  EditingView.swift
//  cinema
//
//  Created by iOS on 27.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

class EditingView: UIView {

    var textPlaceholder: String? {
        didSet {
            textField.placeholder = textPlaceholder
        }
    }

    var text: String? {
        didSet {
            textField.text = text
        }
    }

    private let textField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.cnmFuturaLight(size: 15)
        textField.textColor = UIColor.setColorGray(white: 60)
        textField.textAlignment = .center
        return textField
    } ()

    required init(coder _: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init() {
        super.init(frame: .zero)

        heightAnchor ~= 60

        addSubview(textField.prepareForAutoLayout())
        textField.centerXAnchor ~= centerXAnchor
        textField.centerYAnchor ~= centerYAnchor - 5
        textField.delegate = self

        let separatorView = UIView()
        separatorView.backgroundColor = .cnmDadada
        addSubview(separatorView.prepareForAutoLayout())
        separatorView.bottomAnchor ~= bottomAnchor - 10
        separatorView.trailingAnchor ~= trailingAnchor - 24
        separatorView.leadingAnchor ~= leadingAnchor + 24
        separatorView.heightAnchor ~= 1
    }
}

extension EditingView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
}
