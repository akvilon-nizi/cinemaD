//
//  Constants.swift
//  cinema
//
//  Created by iOS on 06.12.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static let changeProfileAvatar = "changeProfileAvatar"
}

extension String {
    func htmlAttributedString(font: UIFont) -> NSAttributedString? {

        let modifiedFont = String(format: "<span style=\"font-family: \(font.fontName); font-size: \(font.pointSize)\">%@</span>", self)
        guard let data = modifiedFont.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
        guard let html = try? NSMutableAttributedString(
            data: data,
            options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil) else { return nil }
        return html
    }

    func htmlAttributedStringSize(font: UIFont, inset: CGFloat) -> CGFloat {
        if let height = (htmlAttributedString(font: font)?.boundingRect(with: CGSize(width: UIWindow(frame: UIScreen.main.bounds).frame.width - inset, height: 3_000), options: [.usesFontLeading, .usesLineFragmentOrigin, .truncatesLastVisibleLine], context: nil).height) {
            return height
        } else {
            return 0
        }
    }
}
