//
// Created by Александр Масленников on 06.08.17.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

enum TextInputFilter: String {
    case phone = "[0-9]{0,10}"
    case smsCode = "[0-9]{0,5}"
}

protocol TextInputFilterProtocol {
    func filter(textField: UITextField, replacement string: String, filter: TextInputFilter) -> Bool
}

extension TextInputFilterProtocol {

    func filter(textField: UITextField, replacement string: String, filter: TextInputFilter) -> Bool {
        let text = (textField.text ?? "") + string

        if string.isEmpty || text.isEmpty {
            return true
        }

        guard let range = text.range(of: filter.rawValue, options: .regularExpression) else {
            log.info("Wrong input text")
            return false
        }

        if text.distance(from: range.lowerBound, to: range.upperBound) != text.characters.count {
            return false
        }
        return true
    }
}
