//
//  PhoneNumberFormatter.swift
//  cinema
//
//  Created by incetro on 28/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import Foundation

// MARK: - PhoneNumberFormatter

protocol PhoneNumberFormatter {

    func validate(phone: String) -> Bool

    func format(phone: String) -> String

    func unformat(phone: String) -> String
}
