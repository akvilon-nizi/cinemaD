//
//  PhoneNumberFormatterImplementation.swift
//  cinema
//
//  Created by incetro on 28/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import Foundation

// MARK: - PhoneNumberFormatterImplementation

class PhoneNumberFormatterImplementation: PhoneNumberFormatter {

    func validate(phone: String) -> Bool {
        return unformat(phone: phone).count == 11
    }

    func format(phone: String) -> String {

        guard phone.count == 11 else {

            return ""
        }

        var phone = phone

        phone.insert(" ", at: phone.index(phone.startIndex, offsetBy: 9))
        phone.insert(" ", at: phone.index(phone.startIndex, offsetBy: 7))
        phone.insert(" ", at: phone.index(phone.startIndex, offsetBy: 4))
        phone.insert(")", at: phone.index(phone.startIndex, offsetBy: 4))
        phone.insert("(", at: phone.index(phone.startIndex, offsetBy: 1))
        phone.insert(" ", at: phone.index(phone.startIndex, offsetBy: 1))

        if phone.first == "7" {

            phone.insert("+", at: phone.index(phone.startIndex, offsetBy: 0))
        }

        return phone
    }

    func unformat(phone: String) -> String {

        return phone.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
}
