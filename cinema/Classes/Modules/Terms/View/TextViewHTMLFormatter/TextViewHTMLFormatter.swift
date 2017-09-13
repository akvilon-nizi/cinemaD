//
//  TextViewHTMLFormatter.swift
//  foodle
//
//  Created by incetro on 25/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - TextViewHTMLFormatter

protocol TextViewHTMLFormatter {

    func setHTMLText(_ text: String, toTextView textView: UITextView, withFont font: UIFont, textColor: UIColor)
}
