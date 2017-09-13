//
//  ProfileTextView.swift
//  foodle
//
//  Created by incetro on 27/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit
import InputMask

// MARK: - ProfileTextView

class ProfileTextView: UIView {

    weak var delegate: ProfileTextViewDelegate?

    var regex: String?

    var isCorrect: Bool {

        if let regex = regex, let text = textField.text {

            let predicate = NSPredicate(format: "SELF MATCHES %@", regex)

            return predicate.evaluate(with: text)
        }

        return true
    }

    private var placeholder: String = ""

    var text: String {

        get {

            return textField.text ?? ""
        }

        set {

            textField.text = newValue

            if !newValue.isEmpty {

                UIView.animate(withDuration: 0.2, animations: {

                    self.placeholderLabel.alpha = 1
                })
            }

            update()
        }
    }

    var errorText: String {

        get {

            return errorLabel.text ?? ""
        }

        set {

            errorLabel.text = newValue
        }
    }

    let lineView: UIView = {

        let lineView = UIView()

        lineView.backgroundColor = UIColor.fdlWhite

        return lineView
    }()

    let textField: UITextField = {

        let textField = UITextField()

        textField.borderStyle = .none
        textField.font = UIFont.fdlSystemRegular(size: 16)
        textField.textColor = UIColor.fdlGreyishBrown

        return textField
    }()

    let placeholderLabel: UILabel = {

        let placeholderLabel = UILabel()

        placeholderLabel.font = UIFont.fdlSystemRegular(size: 13)
        placeholderLabel.textColor = UIColor.fdlWarmGrey
        placeholderLabel.alpha = 0

        return placeholderLabel
    }()

    let errorLabel: UILabel = {

        let errorLabel = UILabel()

        errorLabel.font = UIFont.fdlSystemRegular(size: 10)
        errorLabel.textColor = UIColor.fdlRedPink
        errorLabel.alpha = 0

        return errorLabel
    }()

    override init(frame: CGRect) {

        super.init(frame: frame)

        setupErrorLabel()
        setupLineView()
        setupTextField()
        setupPlaceholderLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update() {

        if isCorrect {

            UIView.animate(withDuration: 0.2) {

                self.lineView.backgroundColor = UIColor.fdlWhite
                self.errorLabel.alpha = 0
            }

        } else {

            UIView.animate(withDuration: 0.2) {

                self.lineView.backgroundColor = UIColor.fdlRedPink
                self.errorLabel.alpha = 1
            }
        }
    }

    func resign() {

        textField.resignFirstResponder()
    }

    func setPlaceholder(_ placeholder: String) {

        self.placeholder = placeholder
        textField.placeholder = placeholder
        placeholderLabel.text = placeholder
    }

    private func setupPlaceholderLabel() {

        addSubview(placeholderLabel.prepareForAutoLayout())

        placeholderLabel.leadingAnchor ~= leadingAnchor
        placeholderLabel.topAnchor ~= topAnchor
    }

    private func setupTextField() {

        addSubview(textField.prepareForAutoLayout())

        textField.pinToSuperview([.left, .right])
        textField.heightAnchor ~= 20
        textField.bottomAnchor ~= lineView.topAnchor - 4
    }

    private func setupErrorLabel() {

        addSubview(errorLabel.prepareForAutoLayout())

        errorLabel.pinEdgesToSuperviewEdges(excluding: .top)
        errorLabel.heightAnchor ~= 10
    }

    private func setupLineView() {

        addSubview(lineView.prepareForAutoLayout())

        lineView.leadingAnchor ~= leadingAnchor
        lineView.trailingAnchor ~= trailingAnchor
        lineView.bottomAnchor ~= errorLabel.topAnchor - 4
        lineView.heightAnchor ~= 1
    }
}
