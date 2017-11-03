//
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

protocol NavigationBarDecorator {
    func configure(_ navigationBar: UINavigationBar)
}

class WhiteNavigationBarDecorator {
}

extension WhiteNavigationBarDecorator: NavigationBarDecorator {
    func configure(_ navigationBar: UINavigationBar) {
        navigationBar.barTintColor = .clear
        navigationBar.isTranslucent = true
        navigationBar.tintColor = .white
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.darkGray,
            NSFontAttributeName: UIFont.fdlSystemRegular(size: 15)
        ]
    }
}
