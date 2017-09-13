//
//  StandardProfileTextView.swift
//  foodle
//
//  Created by incetro on 05/09/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - StandardProfileTextView

class StandardProfileTextView: ProfileTextView {

    override init(frame: CGRect) {

        super.init(frame: .zero)

        textField.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StandardProfileTextView: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let textFieldRange = NSRange(location: 0, length: textField.text?.characters.count ?? 0)

        if (NSEqualRanges(range, textFieldRange) && string.characters.isEmpty) {

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

        textField.text = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)

        update()

        return false
    }

    func textFieldDidEndEditing(_ textField: UITextField) {

        update()
        delegate?.textFieldViewEditing(self)
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {

        update()
    }
}
