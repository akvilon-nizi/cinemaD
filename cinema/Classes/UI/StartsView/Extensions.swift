//
//  Extensions.swift
//  cinema
//
//  Created by User on 06.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

extension UIButton {
    func setTitleWithColor(title: String, color: UIColor) -> UIButton {
        self.titleLabel?.font = UIFont.cnmFutura(size: 17)
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = color
        self.heightAnchor ~= 49
        self.widthAnchor ~= 284
        self.layer.cornerRadius = 5.0
        return self
    }
}
