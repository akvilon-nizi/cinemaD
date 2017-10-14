//
//  PhoneProfileTextView.swift
//  foodle
//
//  Created by incetro on 05/09/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import InputMask

// MARK: - PhoneProfileTextView

class PhoneProfileTextView: ProfileTextView {

    let maskedDelegate: MaskedTextFieldDelegate

    let format: String

    init(format: String) {
    self.format = format
        maskedDelegate = MaskedTextFieldDelegate(format: format)

        super.init(frame: .zero)

        maskedDelegate.listener = self

        textField.delegate = maskedDelegate
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhoneProfileTextView: MaskedTextFieldDelegateListener {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if textField.text?.isEmpty == true {

            UIView.animate(withDuration: 0.2, animations: {

                self.placeholderLabel.alpha = 0
            })

        } else {

            if placeholderLabel.alpha == 0 {

                UIView.animate(withDuration: 0.2, animations: {

                    self.placeholderLabel.alpha = 1
                })
            }
        }

        update()

        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {

        update()
        delegate?.textFieldViewEditing(self)
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {

        update()
    }
}
