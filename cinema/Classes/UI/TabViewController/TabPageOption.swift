//
//  TabPageOption.swift
//  foodle
//
//  Created by incetro on 11/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

enum HidesTopContentsOnSwipeType {

    case none
    case tabBar
    case navigationBar
    case all
}

struct TabPageOption {

    init() {}

    var fontSize = UIFont.systemFontSize

    var currentColor = UIColor.fdlGreyishBrown

    var defaultColor = UIColor.fdlPinkishGrey

    var tabHeight: CGFloat = 32.0

    var tabMargin: CGFloat = 20.0

    var tabWidth: CGFloat?

    var currentBarHeight: CGFloat = 2.0

    var tabBackgroundColor: UIColor = .white

    var pageBackgoundColor: UIColor = UIColor.white

    var isTranslucent: Bool = true

    var hidesTopViewOnSwipeType: HidesTopContentsOnSwipeType = .none

    var tabBarAlpha: CGFloat {

        return isTranslucent ? 0.95 : 1.0
    }
}
