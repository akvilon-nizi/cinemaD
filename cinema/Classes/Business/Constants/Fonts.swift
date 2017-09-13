//
// Created by Xander on 30.07.17.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

extension UIFont {

    class func fdlSystemRegular(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFontWeightRegular)
    }

    class func fdlSystemMedium(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFontWeightMedium)
    }

    class func fdlGothamProMedium(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "GothamPro-Medium", size: size) else {
            fatalError("GothamPro-Medium font not found")
        }
        return font
    }

    class func fdlGothamProBold(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "GothamPro-Bold", size: size) else {
            fatalError("GothamPro-Bold font not found")
        }
        return font
    }
}
