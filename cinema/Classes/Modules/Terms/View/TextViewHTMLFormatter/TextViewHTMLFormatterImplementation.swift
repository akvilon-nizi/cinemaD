//
//  TextViewHTMLFormatterImplementation.swift
//  foodle
//
//  Created by incetro on 25/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - TextViewHTMLFormatterImplementation

class TextViewHTMLFormatterImplementation {

    fileprivate func html(html: NSString, font: UIFont, color: UIColor) -> NSAttributedString {

        let colorName = colorToHexString(color: color)
        let fontName = font.fontName
        let fontSize = font.pointSize

        let style = "<style>body{color: \(colorName); font-family: '\(fontName)'; font-size:\(fontSize)px;}</style>"
        let htmlString = html.appending(style)

        guard let data = htmlString.data(using: String.Encoding.utf8) else {

            return NSAttributedString(string: "")
        }

        let options: [String: Any] = [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                      NSCharacterEncodingDocumentAttribute: NSNumber(value: String.Encoding.utf8.rawValue)]

        do {

            return try NSAttributedString(data: data, options: options, documentAttributes: nil)

        } catch {

            return NSAttributedString(string: "")
        }
    }

    fileprivate func colorToHexString(color: UIColor) -> String {

        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        color.getRed(&r, green: &g, blue: &b, alpha: &a)

        let rgb: Int = (Int)(r * 255) << 16 | (Int)(g * 255) << 8 | (Int)(b * 255) << 0

        return String(format:"#%06x", rgb)
    }
}

// MARK: - TextViewHTMLFormatter

extension TextViewHTMLFormatterImplementation: TextViewHTMLFormatter {

    func setHTMLText(_ text: String, toTextView textView: UITextView, withFont font: UIFont, textColor: UIColor) {

        textView.font = font

        textView.attributedText = html(html: text as NSString, font: font, color: textColor)
    }
}
