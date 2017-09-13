//
//  NumberTextField.swift
//  foodle
//
//  Created by incetro on 21/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - NumberTextField

class NumberTextField: UITextField {

    weak var deleteDelegate: NumberTextFieldDelegate?

    override func deleteBackward() {

        super.deleteBackward()

        deleteDelegate?.deletePressed()
    }

    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }

    override func selectionRects(for range: UITextRange) -> [Any] {
        return []
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {

        if action == #selector(copy(_:)) || action == #selector(selectAll(_:)) || action == #selector(paste(_:)) {

            return false
        }

        return super.canPerformAction(action, withSender: sender)
    }
}

// MARK: - NumberTextFieldDelegate

protocol NumberTextFieldDelegate: UITextFieldDelegate {

    func deletePressed()
}
